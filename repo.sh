#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Load defaults, then optional local overrides
# shellcheck source=repo.conf
source "${ROOT_DIR}/repo.conf"
if [[ -f "${ROOT_DIR}/repo.local.conf" ]]; then
    # shellcheck source=/dev/null
    source "${ROOT_DIR}/repo.local.conf"
fi

# Colors (disabled if stdout is not a TTY or NO_COLOR is set)
if [[ -t 1 && -z "${NO_COLOR:-}" ]]; then
    C_RESET=$'\033[0m'
    C_BOLD=$'\033[1m'
    C_RED=$'\033[31m'
    C_GREEN=$'\033[32m'
    C_YELLOW=$'\033[33m'
    C_BLUE=$'\033[34m'
    C_CYAN=$'\033[36m'
else
    C_RESET="" C_BOLD="" C_RED="" C_GREEN="" C_YELLOW="" C_BLUE="" C_CYAN=""
fi

log_info()  { printf '%s[INFO]%s %s\n'  "$C_BLUE"   "$C_RESET" "$*"; }
log_ok()    { printf '%s[OK]%s   %s\n'  "$C_GREEN"  "$C_RESET" "$*"; }
log_warn()  { printf '%s[WARN]%s %s\n'  "$C_YELLOW" "$C_RESET" "$*" >&2; }
log_err()   { printf '%s[ERR]%s  %s\n'  "$C_RED"    "$C_RESET" "$*" >&2; }
die()       { log_err "$*"; exit 1; }

usage() {
    cat <<EOF
${C_BOLD}SteavenLinux PKGBUILDS Manager${C_RESET}

Usage: $(basename "$0") <command> [options] [args...]

Commands:
  update [opts]             Update AUR git submodules and show what changed
    -b, --build             Automatically build submodules that updated
    -j, --jobs N            Parallel submodule fetch jobs (default: ${UPDATE_JOBS})

  status, check [opts]      Check which packages are missing/outdated in REPO_DIR
    -a, --all               Also show up-to-date packages
    --no-git                Treat *-git / pkgver() packages as up-to-date if any version is in REPO_DIR

  build [opts] [PKG...]     Build package(s), sign, copy to REPO_DIR, and update DB
    --all                   Build all packages
    --aur                   Build all packages in Aur/
    --custom                Build all packages in SteavenGamerYT/
    --outdated              Build all packages missing/outdated in REPO_DIR
    --changed               Build packages with git changes vs HEAD
    --no-git                Skip *-git / pkgver() packages (in --outdated, only if already in REPO_DIR)
    -k, --keep-going        Continue building remaining packages if one fails
    --no-sign               Do not pass --sign to makepkg
    --no-db                 Skip running repo-add
    -n, --dry-run           Show what would be built without building

  list [--aur|--custom]     List all available packages
  add-aur <pkg>             Add https://aur.archlinux.org/<pkg>.git under Aur/<pkg>
  remove-aur <pkg>          Remove Aur/<pkg> submodule cleanly
  help                      Show this help message

Configuration:
  Defaults live in repo.conf; create repo.local.conf (gitignored) for local overrides.
  Current REPO_DIR:  ${REPO_DIR}
  Current BUILD_DIR: ${BUILD_DIR}
EOF
}

# Discover all package directories (relative to ROOT_DIR) sorted alphabetically.
# Optional filter: "all" (default), "aur", "custom"
discover_packages() {
    local scope="${1:-all}"
    local -a roots=()
    case "$scope" in
        all)    roots=("${ROOT_DIR}/Aur" "${ROOT_DIR}/SteavenGamerYT") ;;
        aur)    roots=("${ROOT_DIR}/Aur") ;;
        custom) roots=("${ROOT_DIR}/SteavenGamerYT") ;;
        *)      die "Unknown scope: ${scope}" ;;
    esac

    local -a existing_roots=()
    local r
    for r in "${roots[@]}"; do
        [[ -d "$r" ]] && existing_roots+=("$r")
    done
    [[ ${#existing_roots[@]} -eq 0 ]] && return 0

    find "${existing_roots[@]}" -maxdepth 3 -name PKGBUILD \
        -not -path '*/src/*' \
        -not -path '*/pkg/*' \
        -not -path "${ROOT_DIR}/Aur/Aur/*" \
        -print0 \
        | while IFS= read -r -d '' pb; do
            local dir="${pb%/PKGBUILD}"
            printf '%s\n' "${dir#"${ROOT_DIR}/"}"
        done | sort -f
}

# Resolve a user-supplied package name or relative path to a single relative package dir.
resolve_package() {
    local query="${1%/}"
    query="${query#./}"

    # Exact relative path match
    if [[ -f "${ROOT_DIR}/${query}/PKGBUILD" ]]; then
        printf '%s\n' "$query"
        return 0
    fi

    local -a matches=()
    local pkg
    while IFS= read -r pkg; do
        if [[ "$(basename "$pkg")" == "$query" ]]; then
            matches+=("$pkg")
        fi
    done < <(discover_packages all)

    if [[ ${#matches[@]} -eq 0 ]]; then
        die "Package not found: '${query}'"
    elif [[ ${#matches[@]} -gt 1 ]]; then
        log_err "Ambiguous package name '${query}'. Matches:"
        printf '  - %s\n' "${matches[@]}" >&2
        exit 1
    fi

    printf '%s\n' "${matches[0]}"
}

# Extract expected package filenames (basenames) for a package directory via makepkg --packagelist.
get_packagelist() {
    local pkg_rel="$1"
    local line
    while IFS= read -r line; do
        [[ -n "$line" ]] && printf '%s\n' "${line##*/}"
    done < <(
        cd "${ROOT_DIR}/${pkg_rel}"
        makepkg --packagelist 2>/dev/null
    )
}

# Extract pkgname from a built .pkg.tar.* file.
get_pkgname_from_archive() {
    local pkgfile="$1"
    local name=""
    if name="$(pacman -Qp "$pkgfile" 2>/dev/null | awk '{print $1}')"; then
        if [[ -n "$name" ]]; then
            printf '%s\n' "$name"
            return 0
        fi
    fi
    # Fallback: strip -<pkgver>-<pkgrel>-<arch>.pkg.tar.*
    local base
    base="$(basename "$pkgfile")"
    base="${base%.pkg.tar.*}"
    printf '%s\n' "${base%-*-*-*}"
}

# Escape regex metacharacters for bash =~
regex_escape() {
    printf '%s' "$1" | sed -e 's/[.[\*^$()+?{|\\]/\\&/g'
}

# Return 0 if a package is a VCS (*-git) or dynamic pkgver() package.
is_vcs_package() {
    local pkg_rel="$1"
    [[ "$(basename "$pkg_rel")" == *-git ]] && return 0
    grep -qE '^[[:space:]]*pkgver[[:space:]]*\(\)' "${ROOT_DIR}/${pkg_rel}/PKGBUILD" 2>/dev/null
}

# Build the exact-pkgname regex used for matching package archives in REPO_DIR.
repo_pkg_pattern() {
    local pkgname="$1"
    local include_sig="${2:-0}"
    local escaped
    escaped="$(regex_escape "$pkgname")"
    if [[ "$include_sig" -eq 1 ]]; then
        printf '^%s-([0-9]+:)?[0-9A-Za-z._+~]+-[0-9.]+-(any|x86_64|i686|aarch64)\\.pkg\\.tar\\.[a-z0-9]+(\\.sig)?$' "$escaped"
    else
        printf '^%s-([0-9]+:)?[0-9A-Za-z._+~]+-[0-9.]+-(any|x86_64|i686|aarch64)\\.pkg\\.tar\\.[a-z0-9]+$' "$escaped"
    fi
}

# Return 0 if REPO_DIR already contains any built archive for exact pkgname.
repo_has_any_version() {
    local pkgname="$1"
    local pattern
    pattern="$(repo_pkg_pattern "$pkgname" 0)"
    local f base
    shopt -s nullglob
    for f in "${REPO_DIR}/${pkgname}-"*.pkg.tar.*; do
        [[ "$f" == *.sig ]] && continue
        base="$(basename "$f")"
        if [[ "$base" =~ $pattern ]]; then
            shopt -u nullglob
            return 0
        fi
    done
    shopt -u nullglob
    return 1
}

# Remove old versions of exact pkgname from REPO_DIR without colliding on prefixes (e.g. kesl vs kesl-gui).
remove_old_repo_packages() {
    local pkgname="$1"
    local pattern
    pattern="$(repo_pkg_pattern "$pkgname" 1)"

    local f base
    shopt -s nullglob
    for f in "${REPO_DIR}/${pkgname}-"*.pkg.tar.*; do
        base="$(basename "$f")"
        if [[ "$base" =~ $pattern ]]; then
            log_info "Removing old repo file: ${base}"
            rm -f -- "$f"
        fi
    done
    shopt -u nullglob
}

# Find the repo database file if UPDATE_DB=1
resolve_repo_db() {
    if [[ -n "${REPO_DB:-}" ]]; then
        printf '%s\n' "$REPO_DB"
        return 0
    fi
    local -a dbs=()
    local f
    shopt -s nullglob
    for f in "${REPO_DIR}"/*.db.tar.*; do
        [[ "$f" == *.sig || "$f" == *.old ]] && continue
        dbs+=("$f")
    done
    shopt -u nullglob

    if [[ ${#dbs[@]} -eq 1 ]]; then
        printf '%s\n' "${dbs[0]}"
    elif [[ ${#dbs[@]} -gt 1 ]]; then
        log_warn "Multiple .db.tar.* files found in ${REPO_DIR}; set REPO_DB in repo.conf to auto-update."
        return 1
    else
        return 1
    fi
}

cmd_list() {
    local scope="all"
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --aur)    scope="aur" ;;
            --custom) scope="custom" ;;
            *)        die "Unknown option for list: $1" ;;
        esac
        shift
    done
    discover_packages "$scope"
}

cmd_status() {
    local show_all=0
    local no_git=0
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -a|--all) show_all=1 ;;
            --no-git) no_git=1 ;;
            *)        die "Unknown option for status: $1" ;;
        esac
        shift
    done

    local repo_available=1
    if [[ ! -d "$REPO_DIR" ]]; then
        log_warn "REPO_DIR does not exist or is not mounted: ${REPO_DIR}"
        repo_available=0
    fi

    local total=0 outdated=0 uptodate=0 skipped_git=0 failed=0
    local pkg file missing
    while IFS= read -r pkg; do
        ((total++)) || true
        local -a expected=()
        if ! mapfile -t expected < <(get_packagelist "$pkg"); then
            printf '%s[ERROR]%s    %s (failed to evaluate PKGBUILD)\n' "$C_RED" "$C_RESET" "$pkg"
            ((failed++)) || true
            continue
        fi
        if [[ ${#expected[@]} -eq 0 ]]; then
            printf '%s[ERROR]%s    %s (empty makepkg --packagelist)\n' "$C_RED" "$C_RESET" "$pkg"
            ((failed++)) || true
            continue
        fi

        missing=0
        if [[ "$repo_available" -eq 1 ]]; then
            for file in "${expected[@]}"; do
                if [[ ! -f "${REPO_DIR}/${file}" ]]; then
                    missing=1
                    break
                fi
            done
        else
            missing=1
        fi

        if [[ "$missing" -eq 1 && "$no_git" -eq 1 && "$repo_available" -eq 1 ]] && is_vcs_package "$pkg"; then
            local all_present=1 pn
            for file in "${expected[@]}"; do
                pn="${file%.pkg.tar.*}"
                pn="${pn%-*-*-*}"
                if ! repo_has_any_version "$pn"; then
                    all_present=0
                    break
                fi
            done
            if [[ "$all_present" -eq 1 ]]; then
                ((skipped_git++)) || true
                ((uptodate++)) || true
                if [[ "$show_all" -eq 1 ]]; then
                    printf '%s[GIT]%s      %s\n' "$C_CYAN" "$C_RESET" "$pkg"
                fi
                continue
            fi
        fi

        if [[ "$missing" -eq 1 ]]; then
            printf '%s[OUTDATED]%s %s -> %s\n' "$C_YELLOW" "$C_RESET" "$pkg" "${expected[0]}"
            ((outdated++)) || true
        else
            ((uptodate++)) || true
            if [[ "$show_all" -eq 1 ]]; then
                printf '%s[OK]%s       %s\n' "$C_GREEN" "$C_RESET" "$pkg"
            fi
        fi
    done < <(discover_packages all)

    echo
    log_info "Summary: ${total} total | ${outdated} missing/outdated | ${uptodate} up-to-date (${skipped_git} git skipped) | ${failed} errors"
}

build_one_package() {
    local pkg_rel="$1"
    local dry_run="$2"
    shift 2
    local -a makepkg_flags=("$@")

    local src_dir="${ROOT_DIR}/${pkg_rel}"
    local slug="${pkg_rel//\//__}"
    local work_dir="${BUILD_DIR}/${slug}"

    if [[ "$dry_run" -eq 1 ]]; then
        log_info "[DRY-RUN] Would build ${pkg_rel} in ${work_dir} -> ${REPO_DIR}"
        return 0
    fi

    log_info "Building ${C_BOLD}${pkg_rel}${C_RESET}..."
    mkdir -p "$BUILD_DIR"
    rm -rf -- "$work_dir"
    cp -a -- "$src_dir" "$work_dir"

    (
        cd "$work_dir"
        makepkg "${makepkg_flags[@]}"
    )

    local -a built_pkgs=()
    local -a built_sigs=()
    local f
    shopt -s nullglob
    for f in "${work_dir}"/*.pkg.tar.*; do
        if [[ "$f" == *.sig ]]; then
            built_sigs+=("$f")
        else
            built_pkgs+=("$f")
        fi
    done
    shopt -u nullglob

    if [[ ${#built_pkgs[@]} -eq 0 ]]; then
        log_err "No .pkg.tar.* artifacts produced for ${pkg_rel}"
        return 1
    fi

    [[ -d "$REPO_DIR" ]] || die "REPO_DIR does not exist: ${REPO_DIR}"

    local pkgname
    for f in "${built_pkgs[@]}"; do
        pkgname="$(get_pkgname_from_archive "$f")"
        remove_old_repo_packages "$pkgname"
    done

    cp -f -- "${built_pkgs[@]}" "$REPO_DIR/"
    if [[ ${#built_sigs[@]} -gt 0 ]]; then
        cp -f -- "${built_sigs[@]}" "$REPO_DIR/"
    fi

    for f in "${built_pkgs[@]}"; do
        COPIED_REPO_PKGS+=("${REPO_DIR}/$(basename "$f")")
    done

    log_ok "Built and deployed ${pkg_rel} (${#built_pkgs[@]} package file(s))"
}

cmd_build() {
    local scope=""
    local mode_outdated=0
    local mode_changed=0
    local no_git=0
    local keep_going=0
    local no_sign=0
    local no_db=0
    local dry_run=0
    local -a raw_targets=()

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --all)          scope="all" ;;
            --aur)          scope="aur" ;;
            --custom)       scope="custom" ;;
            --outdated)     mode_outdated=1 ;;
            --changed)      mode_changed=1 ;;
            --no-git)       no_git=1 ;;
            -k|--keep-going) keep_going=1 ;;
            --no-sign)      no_sign=1 ;;
            --no-db)        no_db=1 ;;
            -n|--dry-run)   dry_run=1 ;;
            -*)             die "Unknown option for build: $1" ;;
            *)              raw_targets+=("$1") ;;
        esac
        shift
    done

    local -a targets=()
    local pkg

    if [[ -n "$scope" ]]; then
        mapfile -t targets < <(discover_packages "$scope")
        if [[ "$no_git" -eq 1 ]]; then
            local -a filtered=()
            for pkg in "${targets[@]}"; do
                is_vcs_package "$pkg" || filtered+=("$pkg")
            done
            targets=("${filtered[@]}")
        fi
    elif [[ "$mode_outdated" -eq 1 ]]; then
        [[ -d "$REPO_DIR" ]] || die "REPO_DIR does not exist: ${REPO_DIR}"
        while IFS= read -r pkg; do
            local -a expected=()
            mapfile -t expected < <(get_packagelist "$pkg" || true)
            local f missing=0
            if [[ ${#expected[@]} -eq 0 ]]; then
                missing=1
            else
                for f in "${expected[@]}"; do
                    [[ ! -f "${REPO_DIR}/${f}" ]] && { missing=1; break; }
                done
            fi
            if [[ "$missing" -eq 1 && "$no_git" -eq 1 ]] && is_vcs_package "$pkg"; then
                local all_present=1 pn
                for f in "${expected[@]}"; do
                    pn="${f%.pkg.tar.*}"
                    pn="${pn%-*-*-*}"
                    if ! repo_has_any_version "$pn"; then
                        all_present=0
                        break
                    fi
                done
                [[ "$all_present" -eq 1 ]] && missing=0
            fi
            [[ "$missing" -eq 1 ]] && targets+=("$pkg")
        done < <(discover_packages all)
    elif [[ "$mode_changed" -eq 1 ]]; then
        local -a changed_paths=()
        local status_line
        while IFS= read -r status_line; do
            status_line="${status_line:3}"
            status_line="${status_line##* -> }"
            changed_paths+=("$status_line")
        done < <(git -C "$ROOT_DIR" -c core.quotepath=false status --porcelain)
        while IFS= read -r pkg; do
            local p
            for p in "${changed_paths[@]}"; do
                if [[ "$p" == "$pkg" || "$p" == "$pkg/"* ]]; then
                    targets+=("$pkg")
                    break
                fi
            done
        done < <(discover_packages all)
    elif [[ ${#raw_targets[@]} -gt 0 ]]; then
        local t
        for t in "${raw_targets[@]}"; do
            targets+=("$(resolve_package "$t")")
        done
    else
        die "Specify package name(s) or one of --all, --aur, --custom, --outdated, --changed."
    fi

    if [[ ${#targets[@]} -eq 0 ]]; then
        log_ok "Nothing to build."
        return 0
    fi

    local -a effective_flags=()
    local fl
    for fl in "${MAKEPKG_FLAGS[@]}"; do
        if [[ "$no_sign" -eq 1 && "$fl" == "--sign" ]]; then
            continue
        fi
        effective_flags+=("$fl")
    done

    log_info "Packages queued (${#targets[@]}): ${targets[*]}"

    COPIED_REPO_PKGS=()
    local -a succeeded=()
    local -a failed=()

    for pkg in "${targets[@]}"; do
        if build_one_package "$pkg" "$dry_run" "${effective_flags[@]}"; then
            succeeded+=("$pkg")
        else
            failed+=("$pkg")
            log_err "Failed to build ${pkg}"
            if [[ "$keep_going" -eq 0 ]]; then
                break
            fi
        fi
    done

    if [[ "$dry_run" -eq 0 && "$no_db" -eq 0 && "$UPDATE_DB" -eq 1 && ${#COPIED_REPO_PKGS[@]} -gt 0 ]]; then
        local db_path=""
        if db_path="$(resolve_repo_db)"; then
            local -a db_flags=("${REPO_ADD_FLAGS[@]}")
            local has_sign=0 fl
            for fl in "${db_flags[@]}"; do
                [[ "$fl" == "-s" || "$fl" == "--sign" ]] && has_sign=1
            done
            if [[ "$has_sign" -eq 0 && -f "${db_path}.sig" ]]; then
                db_flags+=(--sign)
            fi
            log_info "Updating repo database: ${db_path}"
            repo-add "${db_flags[@]}" "$db_path" "${COPIED_REPO_PKGS[@]}"
            log_ok "Database updated."
        else
            log_warn "No repo database found in ${REPO_DIR}; skipping repo-add."
        fi
    fi

    echo
    log_info "Build finished: ${#succeeded[@]} succeeded, ${#failed[@]} failed."
    if [[ ${#failed[@]} -gt 0 ]]; then
        log_err "Failed packages: ${failed[*]}"
        return 1
    fi
}

cmd_update() {
    local do_build=0
    local jobs="${UPDATE_JOBS}"
    local -a extra_build_args=()

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -b|--build)      do_build=1 ;;
            -j|--jobs)       shift; jobs="${1:?Missing value for --jobs}" ;;
            -k|--keep-going) extra_build_args+=("--keep-going") ;;
            *)               die "Unknown option for update: $1" ;;
        esac
        shift
    done

    declare -A before_sha=()
    local sha path
    while read -r sha path _; do
        sha="${sha#[-+U]}"
        before_sha["$path"]="$sha"
    done < <(git -C "$ROOT_DIR" submodule status --recursive)

    log_info "Updating submodules (jobs=${jobs})..."
    git -C "$ROOT_DIR" submodule update --remote --recursive --jobs "$jobs"

    local -a updated_pkgs=()
    while read -r sha path _; do
        sha="${sha#[-+U]}"
        if [[ -n "${before_sha[$path]:-}" && "${before_sha[$path]}" != "$sha" ]]; then
            updated_pkgs+=("$path")
            printf '%s[UPDATED]%s %s (%s -> %s)\n' \
                "$C_CYAN" "$C_RESET" "$path" "${before_sha[$path]:0:7}" "${sha:0:7}"
            git -C "${ROOT_DIR}/${path}" log --oneline "${before_sha[$path]}..${sha}" 2>/dev/null \
                | sed 's/^/          /' || true
        fi
    done < <(git -C "$ROOT_DIR" submodule status --recursive)

    if [[ ${#updated_pkgs[@]} -eq 0 ]]; then
        log_ok "All AUR submodules are already up to date."
        return 0
    fi

    echo
    log_info "${#updated_pkgs[@]} submodule(s) updated."

    if [[ "$do_build" -eq 1 ]]; then
        cmd_build "${extra_build_args[@]}" "${updated_pkgs[@]}"
    else
        log_info "To build updated packages, run:"
        printf '  ./repo.sh build %s\n' "${updated_pkgs[*]}"
    fi
}

cmd_add_aur() {
    local pkg="${1:-}"
    [[ -n "$pkg" ]] || die "Usage: $(basename "$0") add-aur <pkg-name>"
    [[ "$pkg" != */* ]] || die "Pass just the AUR package name (without 'Aur/'), got: ${pkg}"
    local target="Aur/${pkg}"
    [[ ! -e "${ROOT_DIR}/${target}" ]] || die "${target} already exists."

    git -C "$ROOT_DIR" submodule add "https://aur.archlinux.org/${pkg}.git" "$target"
    log_ok "Added AUR submodule ${target}"
}

cmd_remove_aur() {
    local pkg="${1:-}"
    [[ -n "$pkg" ]] || die "Usage: $(basename "$0") remove-aur <pkg-name>"
    pkg="${pkg#Aur/}"
    local target="Aur/${pkg}"
    [[ -e "${ROOT_DIR}/${target}" ]] || die "${target} does not exist."

    git -C "$ROOT_DIR" submodule deinit -f -- "$target"
    git -C "$ROOT_DIR" rm -f -- "$target"
    rm -rf -- "${ROOT_DIR}/.git/modules/${target}"
    log_ok "Removed AUR submodule ${target}"
}

main() {
    local cmd="${1:-help}"
    shift || true

    case "$cmd" in
        update)       cmd_update "$@" ;;
        status|check) cmd_status "$@" ;;
        build)        cmd_build "$@" ;;
        list)         cmd_list "$@" ;;
        add-aur)      cmd_add_aur "$@" ;;
        remove-aur)   cmd_remove_aur "$@" ;;
        help|-h|--help) usage ;;
        *)            die "Unknown command: '${cmd}'. Run '$(basename "$0") help' for usage." ;;
    esac
}

main "$@"

