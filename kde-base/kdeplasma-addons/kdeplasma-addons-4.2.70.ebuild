# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdeplasma-addons"
OPENGL_REQUIRED="optional"
WEBKIT_REQUIRED="always"
inherit kde4-base

DESCRIPTION="Extra Plasma applets and engines."
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"

KEYWORDS="~amd64 ~x86"
IUSE="debug desktopglobe exif semantic-desktop"

DEPEND="
	>=kde-base/kdelibs-${PV}:${SLOT}[kdeprefix=,opengl?,semantic-desktop?]
	>=kde-base/kdepimlibs-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/plasma-workspace-${PV}:${SLOT}[kdeprefix=]
	desktopglobe? ( >=kde-base/marble-${PV}:${SLOT}[kdeprefix=] )
	exif? ( >=kde-base/libkexiv2-${PV}:${SLOT}[kdeprefix=] )
"
RDEPEND="${DEPEND}
	!kdeprefix? ( !kde-misc/lancelot-menu )
	semantic-desktop? ( >=kde-base/nepomuk-${PV}:${SLOT}[kdeprefix=] )
"

src_prepare() {
	sed -i -e 's/${KDE4WORKSPACE_PLASMACLOCK_LIBRARY}/plasmaclock/g' \
		-e 's/${KDE4WORKSPACE_WEATHERION_LIBRARY}/weather_ion/g' \
		-e 's/${KDE4WORKSPACE_TASKMANAGER_LIBRARY}/taskmanager/g' \
		{libs/plasmaweather,applets/{binary-clock,fuzzy-clock,weather,weatherstation,lancelot/app/src}}/CMakeLists.txt \
		|| die "Failed to patch CMake files"

	sed -i -e 's/(KDE4_PLASMA_OPENGL_FOUND)/(KDE4_PLASMA_OPENGL_FOUND AND OPENGL_FOUND)/g' \
		applets/CMakeLists.txt \
		|| die "Failed to make OpenGL applets optional"

	kde4-base_src_prepare
}

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DDBUS_INTERFACES_INSTALL_DIR=${KDEDIR}/share/dbus-1/interfaces/
		$(cmake-utils_use_with exif Kexiv2)
		$(cmake-utils_use_with desktopglobe Marble)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with semantic-desktop Nepomuk)"

	kde4-base_src_configure
}
