# SteavenLinux PKGBUILDs

PKGBUILDs for packages used in SteavenLinux that are not available in the official Arch Linux repositories or Chaotic-AUR.

## Repository Structure

- **`Aur/`** — AUR packages tracked as git submodules (packages in the AUR but not in Chaotic-AUR).
- **`SteavenGamerYT/`** — Custom SteavenLinux packages, meta-packages, and packages not in the AUR (or where the AUR version is broken).
  - **`SteavenGamerYT/1- Drivers/`** — Hardware/driver meta-packages (`SteavenLinux-Amd-meta`, `SteavenLinux-Nvidia-meta`, etc.).
- **`repo.sh`** — Unified CLI for updating submodules, checking outdated packages, building/signing, deploying to the pacman repo, and running `repo-add`.
- **`update.sh`** — Convenience wrapper for `./repo.sh update`.
- **`repo.conf`** — Default configuration (create a gitignored `repo.local.conf` for local overrides).

## Usage

### 1. Update AUR Submodules

```bash
./update.sh                  # Fetch latest AUR submodule commits and show what changed
./update.sh --build          # Update submodules and automatically build changed ones
./update.sh -b -k            # Same, continuing past individual build failures
```

### 2. Check Package Status

```bash
./repo.sh status             # Show missing or outdated packages in REPO_DIR
./repo.sh status --no-git    # Treat *-git / pkgver() packages as up-to-date if already in REPO_DIR
./repo.sh status -a          # Include up-to-date packages
```

### 3. Build & Deploy Packages

`./repo.sh build` copies each package to `BUILD_DIR`, runs `makepkg`, removes old versions of the exact built `pkgname`(s) from `REPO_DIR`, copies the new `.pkg.tar.*` and `.sig` files, and updates/signs the pacman database via `repo-add`.

```bash
# Build specific package(s) by name or relative path
./repo.sh build cursor-bin
./repo.sh build SteavenLinux-Amd-meta proton-em
./repo.sh build Aur/unigine-heaven

# Build by group
./repo.sh build --outdated           # Build all missing/outdated packages
./repo.sh build --outdated --no-git  # Build outdated packages, skipping *-git / pkgver() already in REPO_DIR
./repo.sh build --changed            # Build packages with uncommitted/staged git changes
./repo.sh build --aur                # Build all Aur/ packages
./repo.sh build --custom             # Build all SteavenGamerYT/ packages
./repo.sh build --all -k             # Build everything, continuing if a package fails

# Useful flags
./repo.sh build --outdated -n        # Dry-run: show what would be built
./repo.sh build cursor-bin --no-sign # Skip GPG signing in makepkg
./repo.sh build cursor-bin --no-db   # Skip running repo-add
```

### 4. Manage AUR Submodules & List Packages

```bash
./repo.sh list                       # List all discovered packages
./repo.sh list --aur                 # List only Aur/ packages
./repo.sh list --custom              # List only SteavenGamerYT/ packages
./repo.sh add-aur <pkg>              # Add https://aur.archlinux.org/<pkg>.git under Aur/<pkg>
./repo.sh remove-aur <pkg>           # Cleanly remove Aur/<pkg> submodule
```

## Configuration

Defaults are defined in [`repo.conf`](repo.conf):

| Variable | Default | Description |
| --- | --- | --- |
| `REPO_DIR` | `/mnt/hdd/SteavenRepo/x86_64` | Destination directory for built packages and signatures |
| `BUILD_DIR` | `${HOME}/ah` | Scratch directory used for building |
| `MAKEPKG_FLAGS` | `(-sr --sign)` | Flags passed to `makepkg` |
| `REPO_DB` | `""` (auto-detected) | Path to `*.db.tar.*` inside `REPO_DIR` |
| `UPDATE_DB` | `1` | Run `repo-add` after building (`0` to disable) |
| `REPO_ADD_FLAGS` | `(--sign)` | Extra flags passed to `repo-add` |
| `UPDATE_JOBS` | `8` | Parallel jobs for `git submodule update` |

To customize settings without modifying tracked files, create `repo.local.conf` (gitignored).
