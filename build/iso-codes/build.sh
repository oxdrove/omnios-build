#!/usr/bin/bash
#
# {{{ CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License, Version 1.0 only
# (the "License").  You may not use this file except in compliance
# with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END }}}
#
# Copyright 2017 OmniTI Computer Consulting, Inc.  All rights reserved.
# Copyright 2018 OmniOS Community Edition (OmniOSce) Association.
# Use is subject to license terms.
#
. ../../lib/functions.sh

PROG=iso-codes
VER=4.0
VERHUMAN=$VER
PKG=data/iso-codes
SUMMARY="ISO code lists and translations"
DESC="Lists of various ISO standards "
DESC+="(e.g. country, language, language scripts, and currency names)"

BUILD_DEPENDS_IPS="data/iso-codes"

install_xml() {
    # As of iso-code 4.0, the .xml files are no longer included. We continue
    # to ship them for now, but they will no longer be updated.
    # The XML files include a header pointing users at the JSON ones.
    logcmd mkdir -p $DESTDIR/usr/share/xml || logerr "mkdir"
    logcmd rsync -avr /usr/share/xml/iso-codes/ \
        $DESTDIR/usr/share/xml/iso-codes/ || logerr "rsync"
}

set_arch 32

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
install_xml
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
