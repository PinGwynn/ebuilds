# cat xhprof-9999.ebuild 
# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:
EAPI="4"

PHP_EXT_NAME="xhprof"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-5"

inherit php-ext-source-r2 git-2

PHP_EXT_S=${S}

DESCRIPTION="A Hierarchical Profiler for PHP by Paul Reinheimer"
HOMEPAGE="https://github.com/preinheimer/xhprof"
EGIT_REPO_URI="git://github.com/preinheimer/xhprof.git"
LICENSE="PHP-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
DEPEND="dev-lang/php"
RDEPEND="${DEPEND}"

src_unpack() {
	git-2_src_unpack
	# create the default modules directory to be able
	# to use the php-ext-source-r2 eclass to configure/build
	#ln -s extension "${S}/modules"
}

src_prepare() {
    epatch "${FILESDIR}"/${P}-php5.5.patch
	epatch "${FILESDIR}"/${P}-php5.5-1.patch
    for slot in $(php_get_slots); do
        cp -r "${S}/extension" "${WORKDIR}/${slot}"
    done

	php-ext-source-r2_src_prepare
	eautoreconf
}
