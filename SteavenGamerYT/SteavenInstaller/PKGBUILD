# Maintainer: omarhanykasban <omarhanykasban706@gmail.com>

pkgname=SteavenInstaller
pkgver=1.0.0
pkgrel=1
pkgdesc="SteavenGamerYT's SteavenLinux's Installer"
arch=('any')
url="https://github.com/SteavenLinux/SteavenInstaller"
license=('MIT')
makedepends=('git')
source=(
  "SteavenInstaller::git+https://github.com/SteavenLinux/SteavenInstaller.git"
)
sha256sums=('SKIP')

pkgver() {
  cd "$srcdir/SteavenInstaller"
  git rev-parse --short HEAD
}

package() {
  cd "$srcdir/SteavenInstaller"
  install -Dm755 steavenlinuxinstall "$pkgdir/usr/bin/steavenlinuxinstall"
}
