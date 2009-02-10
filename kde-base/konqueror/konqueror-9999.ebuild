# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdebase-apps"
inherit kde4-meta

DESCRIPTION="KDE: Web browser, file manager, ..."
IUSE="+auth +bookmarks debug htmlhandbook"
KEYWORDS=""
# 4 of 4 tests fail. Last checked for 4.0.3
RESTRICT="test"

DEPEND="
	>=kde-base/libkonq-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	>=kde-base/kdebase-kioslaves-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kfind-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/kurifilter-plugins-${PV}:${SLOT}[kdeprefix=]
	auth? ( >=kde-base/kpasswdserver-${PV}:${SLOT}[kdeprefix=] )
	bookmarks? ( >=kde-base/keditbookmarks-${PV}:${SLOT}[kdeprefix=] )
"

KMEXTRA="
	doc/${PN}/
"
KMEXTRACTONLY="
	lib/konq/
"

pkg_postinst() {
	kde4-meta_pkg_postinst

	echo
	elog "If you want to use konqueror as a filemanager, install the dolphin kpart:"
	elog "emerge -1 kde-base/dolphin:${SLOT}"
	elog
	elog "To use Java on webpages: emerge jre"
	echo
}
