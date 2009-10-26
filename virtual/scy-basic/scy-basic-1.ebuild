# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="virtual package for Scy's most beloved tools"
HOMEPAGE="http://scytale.name/proj/overlay/"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( app-admin/metalog virtual/logger )
	app-misc/screen
	app-portage/eix
	app-portage/gentoolkit
	app-portage/layman[git,subversion]
	dev-util/ccache
	dev-util/strace
	media-fonts/terminus-font
	media-gfx/imagemagick[jpeg,png,svg]
	net-analyzer/netcat
	net-analyzer/wireshark
	net-dns/bind-tools
	net-firewall/iptables
	net-im/irssi-xmpp
	net-irc/irssi-otr
	net-misc/dhcpcd
	net-misc/openvpn[iproute2]
	net-misc/tor
	net-print/cups
	sys-devel/gdb
	sys-fs/cryptsetup
	"
