# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="A Personal Organizer for KDE"
KEYWORDS=""
IUSE="debug htmlhandbook"

DEPEND="
	app-crypt/gpgme
	>=kde-base/libkdepim-${PV}:${SLOT}[kdeprefix=]
	kontact? ( >=kde-base/kaddressbook-${PV}:${SLOT}[kdeprefix=] )
"
RDEPEND="${DEPEND}
	>=kde-base/ktimezoned-${PV}:${SLOT}[kdeprefix=]
"

KMLOADLIBS="libkdepim"
KMEXTRA="kdgantt1"

# xml targets from kmail are being uncommented by kde4-meta.eclass
KMEXTRACTONLY="
	kaddressbook/org.kde.KAddressbook.Core.xml
	kmail/
	knode/org.kde.knode.xml
	libkdepim
"

src_unpack() {
	if use kontact; then
		KMLOADLIBS="${KMLOADLIBS} kontactinterfaces"
		KMEXTRA="${KMEXTRA} kontact/plugins/planner"
	fi

	kde4-meta_src_unpack
}

src_prepare() {
	if use kontact; then
		# Fix target_link_libraries for now
		sed -i -e's/kaddressbookprivate ${KDE4_KCAL_LIBS}/${KDE4_KCAL_LIBS}/' \
			kontact/plugins/planner/CMakeLists.txt \
			|| die "Failed to remove kaddressbookprivate from link"
	fi

	kde4-meta_src_prepare
}
