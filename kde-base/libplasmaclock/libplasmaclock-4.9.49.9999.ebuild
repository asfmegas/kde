# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

KMNAME="kde-workspace"
KMMODULE="libs/plasmaclock"
inherit kde4-meta

DESCRIPTION="Libraries for KDE Plasma's clocks"
KEYWORDS=""
IUSE="debug +holidays"

DEPEND="
	$(add_kdebase_dep kephal)
	holidays? ( $(add_kdebase_dep kdepimlibs) )
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

KMEXTRACTONLY="
	libs/kephal/
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with holidays KdepimLibs)
	)

	kde4-meta_src_configure
}
