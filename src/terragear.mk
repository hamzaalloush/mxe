# This file is part of MXE.
# See index.html for further information.

PKG             := terragear
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.0
$(PKG)_CHECKSUM := f5e16880ea94ab1feed98059fb51bbfbcad738c0
$(PKG)_SUBDIR   := wlbraggs-terragear.git
$(PKG)_FILE     := wlbraggs-terragear-1a7ecc259b37fec9c5a013249dfe2f4301575a15.tar.bz2
$(PKG)_URL      := https://gitlab.com/fgear/wlbraggs-terragear/repository/archive.tar.bz2
$(PKG)_DEPS     := gcc cgal gdal simgear

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://mirrors.ibiblio.org/osgearth/ftp/Source/' | \
    $(SED) -n 's,.*terragear-\([0-9]*\.[0-9]*[02468]\.[^<]*\)\.tar.*,\1,p' | \
    grep -v rc | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    mkdir '$(1).build'
    cd '$(1).build' && cmake '$(1)' \
        -DCMAKE_TOOLCHAIN_FILE='$(CMAKE_TOOLCHAIN_FILE)' \
	-DCMAKE_CXX_FLAGS='-D__STDC_CONSTANT_MACROS -D_USE_MATH_DEFINES -fpermissive -std=c++11' \
	-DSIMGEAR_COMPILE_TEST_EXITCODE=0
    $(MAKE) -C '$(1).build' -j '$(JOBS)' install VERBOSE=1
endef
