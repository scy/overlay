# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xdm/xdm-1.1.9.ebuild,v 1.5 2009/10/11 11:17:26 nixnut Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit multilib x-modular pam

DEFAULTVT="vt7"

DESCRIPTION="X.Org xdm application"

KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE="ipv6 pam xconsole"

RDEPEND="x11-apps/xrdb
	x11-libs/libXdmcp
	x11-libs/libXaw
	>=x11-apps/xinit-1.0.2-r3
	x11-libs/libXinerama
	x11-libs/libX11
	x11-libs/libXt
	x11-apps/sessreg
	xconsole? ( x11-apps/xconsole )"
DEPEND="${RDEPEND}
	x11-proto/xineramaproto
	x11-proto/xproto"

PATCHES=( "${FILESDIR}"/wtmp.patch
	"${FILESDIR}"/xwilling-hang.patch )

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable ipv6)
		$(use_with pam)
		--with-default-vt=${DEFAULTVT}
		--with-xdmconfigdir=/etc/X11/xdm"
}

src_install() {
	x-modular_src_install

	if ! use xconsole && [ -e "${D}/usr/lib/X11/xdm/Xsetup_0" ]; then
		# Empty unneeded setup file which spawns xconsole.
		echo '#!/bin/sh' > "${D}/usr/lib/X11/xdm/Xsetup_0" || die 'cannot write Xsetup_0'
	fi

	exeinto /usr/$(get_libdir)/X11/xdm
	doexe "${FILESDIR}"/Xsession
	newpamd "${FILESDIR}"/xdm.pamd xdm

	# Keep /var/lib/xdm. This is where authfiles are stored. See #286350.
	keepdir /var/lib/xdm
}

pkg_preinst() {
	x-modular_pkg_preinst

	# Check for leftover /usr/lib/X11/xdm symlink
	if [[ -L "/usr/lib/X11/xdm" ]]; then
		ewarn "/usr/lib/X11/xdm is a symlink; deleting."
		rm /usr/lib/X11/xdm
	fi
}
