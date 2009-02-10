# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdegames"
OPENGL_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="KDE Sudoku"
KEYWORDS=""
IUSE="debug htmlhandbook"

RDEPEND="
	!kdeprefix? ( !games-puzzle/ksudoku )
"
