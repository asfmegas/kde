# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-runtime"
KMMODULE="kioslave"
inherit kde4-meta

DESCRIPTION="kioslave: the kde VFS framework - kioslave plugins present a filesystem-like view of arbitrary data"
KEYWORDS=""
IUSE="bzip2 debug htmlhandbook openexr samba"
RESTRICT="test"

DEPEND="
	dev-libs/cyrus-sasl
	sys-apps/dbus
	sys-apps/hal
	x11-libs/libXcursor
	openexr? ( media-libs/openexr )
	samba? ( net-fs/samba )
"
RDEPEND="${DEPEND}
	>=kde-base/kdesu-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kdialog-${PV}:${SLOT}[kdeprefix=]
	virtual/ssh
"

KMEXTRA="
	kioexec
	kdeeject
"

src_unpack() {
	if use htmlhandbook; then
		KMEXTRA="${KMEXTRA} doc/kioslave"
	fi

	kde4-meta_src_unpack
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with bzip2 BZip2)
		$(cmake-utils_use_with samba Samba)
		$(cmake-utils_use_with openexr OpenEXR)"

	kde4-meta_src_configure
}

pkg_postinst() {
	echo
	elog "Note that if you upgrade strigi, you have to rebuild this package."
	echo

	kde4-meta_pkg_postinst
}
