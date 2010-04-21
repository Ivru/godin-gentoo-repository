# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/maven-bin/maven-bin-2.1.0.ebuild,v 1.1 2009/05/12 19:33:02 ali_bush Exp $

inherit java-pkg-2

MY_PN=apache-${PN%%-bin}
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Project Management and Comprehension Tool for Java"
#SRC_URI="mirror://apache/maven/binaries/apache-maven-3.0-alpha-7-bin.tar.gz"
SRC_URI="https://repository.apache.org/content/repositories/maven-042/org/apache/maven/apache-maven/3.0-beta-1/apache-maven-3.0-beta-1-bin.tar.gz"
HOMEPAGE="http://maven.apache.org/"
LICENSE="Apache-2.0"
SLOT="3.0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=virtual/jdk-1.5
	app-admin/eselect-maven"

IUSE=""

S="${WORKDIR}/apache-maven-3.0-beta-1"

MAVEN=${PN}-${SLOT}
MAVEN_SHARE="/usr/share/${MAVEN}"

src_unpack() {
	unpack ${A}

	rm -v "${S}"/bin/*.bat || die
	chmod 644 "${S}"/boot/*.jar || die
	chmod 644 "${S}"/lib/*.jar || die
}

# TODO we should use jars from packages, instead of what is bundled
src_install() {
	dodir "${MAVEN_SHARE}"
	cp -Rp bin boot conf lib "${D}/${MAVEN_SHARE}" || die "failed to copy"

	java-pkg_regjar "${D}/${MAVEN_SHARE}"/lib/*.jar

	dodoc NOTICE.txt README.txt || die

	dodir /usr/bin
	dosym "${MAVEN_SHARE}/bin/mvn" /usr/bin/mvn-${SLOT}
}
