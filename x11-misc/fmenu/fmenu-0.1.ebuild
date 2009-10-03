# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs savedconfig

DESCRIPTION="a generic, highly customizable, and efficient menu for the X Window System with enhanced features"
HOMEPAGE="http://scytale.name/proj/fmenu/"
SRC_URI="http://github.com/scy/${PN}/tarball/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="xinerama"

DEPEND="x11-libs/libX11
        xinerama? ( x11-libs/libXinerama )"
RDEPEND="${DEPEND}"
S="${WORKDIR}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	S="${S}/$(ls -d scy-${PN}-*)"
	cd "${S}"

	sed -i \
		-e "s/CFLAGS = -std=c99 -pedantic -Wall -Os/CFLAGS += -std=c99 -pedantic -Wall -g/" \
		-e "s/LDFLAGS = -s/LDFLAGS += -g/" \
		-e "s/XINERAMALIBS =/XINERAMALIBS ?=/" \
		-e "s/XINERAMAFLAGS =/XINERAMAFLAGS ?=/" \
		config.mk || die "sed failed"

	if use savedconfig; then
		restore_config config.h
	fi
}

src_compile() {
	local msg
	use savedconfig && msg=", please check the configfile"
	if use xinerama; then
		emake CC=$(tc-getCC) || die "emake failed${msg}"
	else
		emake CC=$(tc-getCC) XINERAMAFLAGS="" XINERAMALIBS="" \
			|| die "emake failed${msg}"
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"

	insinto /usr/share/${PN}
	newins config.h ${PF}.config.h

	dodoc README

	save_config config.h
}

pkg_postinst() {
	einfo "This ebuild has support for user defined configs"
	einfo "Please read this ebuild for more details and re-emerge as needed"
	einfo "if you want to add or remove functionality for ${PN}"
}
