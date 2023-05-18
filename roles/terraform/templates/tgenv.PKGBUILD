# Maintainer: Johannes Wienke <languitar@semipol.de>
pkgname=tgenv
pkgver=1.0.0
pkgrel=2
epoch=
pkgdesc="Terragrunt version manager inspired by tfenv"
arch=("x86_64")
url="https://github.com/tgenv/tgenv"
license=('MIT')
groups=()
depends=()
makedepends=()
checkdepends=()
optdepends=()
provides=("terragrunt")
source=("https://github.com/tgenv/tgenv/archive/v${pkgver}.tar.gz")
sha512sums=('14095b537a3cda910d4b977d5b3d1bfdbc758cdcdc9425212561855e251443cb226821c00fe810d17fbe99ab6aadbdd2ab6b1d272ba6b65c006c61d9b1d88ad6')
validpgpkeys=()
conflicts=("terragrunt")
install="${pkgname}.install"

package() {
    cd "${srcdir}/${pkgname}-${pkgver}"
    mkdir -p "${pkgdir}/usr/bin"
    mkdir -p "${pkgdir}/opt/tgenv/"

	# This patches tgenv to use a separate dir for versions and the default version
	sed -i 's:${TGENV_ROOT}/version:/var/lib/tgenv/version:g' libexec/tgenv-*

    cp -R "bin" "${pkgdir}/opt/tgenv/bin"
    cp -R "libexec" "${pkgdir}/opt/tgenv/libexec"
    cp "CHANGELOG.md" "${pkgdir}/opt/tgenv/CHANGELOG.md"

    ln -s "/opt/tgenv/bin/${pkgname}" "${pkgdir}/usr/bin/${pkgname}"
    ln -s "/opt/tgenv/bin/terragrunt" "${pkgdir}/usr/bin/terragrunt"
}
