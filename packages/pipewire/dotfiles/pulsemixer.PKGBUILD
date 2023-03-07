# pulsemixer with source exclusions
# Maintainer: Alex Talker < alextalker at openmailbox dot org >
# Previous maintainer: Jeff Parent <jecxjo@sdf.lonestar.org>
_gitbase=pulsemixer
pkgname=${_gitbase}-git
pkgver=155.a9c852e
pkgrel=1
epoch=1
pkgdesc="cli and curses mixer for pulseaudio. Git version"
arch=('any')
url="https://github.com/ewok/${_gitbase}"
license=('GPL3')
depends=('python' 'pulseaudio')
makedepends=('git')
conflicts=($_gitbase)
replaces=($_gitbase)
source=("git+https://github.com/ewok/${_gitbase}.git")
md5sums=('SKIP')

pkgver() {
  cd "$_gitbase"
  echo $(git rev-list --count HEAD).$(git rev-parse --short HEAD)
}

package() {
  cd "$srcdir/$_gitbase"
  install -m 755 -d "$pkgdir/usr/bin"
  install -m 755 pulsemixer "$pkgdir/usr/bin/"
}

# vim:set ts=2 sw=2 et:
