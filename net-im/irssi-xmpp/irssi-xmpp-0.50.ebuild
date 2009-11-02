# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs

EAPI="2"

DESCRIPTION="An irssi plugin providing Jabber/XMPP support"
HOMEPAGE="http://cybione.org/~irssi-xmpp/"
SRC_URI="http://cybione.org/~${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-irc/irssi-0.8.13
	>=net-libs/loudmouth-1.2.0[debug]"
RDEPEND="${DEPEND}"

src_prepare() {
	# Patch Makefile to remove /irssi-xmpp suffix for docs.
	sed -i -e 's#\${IRSSI_DOC}/irssi-xmpp$#${IRSSI_DOC}#' \
		Makefile || die "patching Makefile failed"
}

src_compile() {
	emake CC="$(tc-getCC)" PREFIX="/usr" || die "emake failed"
}

src_install() {
	emake \
		DESTDIR="${D}" IRSSI_DOC="/usr/share/doc/${PF}" \
		install || die "install failed"
}
