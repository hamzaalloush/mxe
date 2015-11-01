# This file is part of MXE.
# See index.html for further information.

PKG             := osgearth
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.6.1
$(PKG)_CHECKSUM := 9d1a7814569e21f369e53b5fbc116018b194328186ba469d28b22a42315010e3
$(PKG)_SUBDIR   := gwaldron-osgearth-350f1a0
$(PKG)_FILE     := gwaldron-osgearth-350f1a0.tar.gz
$(PKG)_URL      := https://github.com/gwaldron/osgearth/tarball/osgearth-2.6
$(PKG)_DEPS     := gcc openscenegraph curl gdal geos

define $(PKG)_UPDATE
    $(WGET) -q -O- 'http://mirrors.ibiblio.org/osgearth/ftp/Source/' | \
    $(SED) -n 's,.*osgearth-\([0-9]*\.[0-9]*[02468]\.[^<]*\)\.tar.*,\1,p' | \
    grep -v rc | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    mkdir '$(1).build'
    cd '$(1).build' && cmake '$(1)' \
        -DCMAKE_TOOLCHAIN_FILE='$(CMAKE_TOOLCHAIN_FILE)'
    $(MAKE) -C '$(1).build' -j '$(JOBS)' install VERBOSE=1
endef
