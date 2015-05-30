# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK=true
PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 kde5

DESCRIPTION="KDE Interactive Geometry tool"
HOMEPAGE="http://www.kde.org/applications/education/kig http://edu.kde.org/kig"
KEYWORDS="~amd64 ~x86"
IUSE="scripting"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	scripting? ( >=dev-libs/boost-1.48:=[python,${PYTHON_USEDEP}] )
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-4.12.0-boostpython.patch" )

pkg_setup() {
	python-single-r1_pkg_setup
	kde5_pkg_setup
}

src_prepare() {
	kde5_src_prepare

	python_fix_shebang .
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package scripting BoostPython)
	)

	kde5_src_configure
}
