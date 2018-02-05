#!/bin/bash

set -e
set -x

CC=clang
CXX=clang++

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
BUILDFOLDER="$SCRIPTPATH/_build/nativebuild"

if [ -z "$BUILD_TYPE" ]
then
  . ./config.release
fi

rm -rf $BUILDFOLDER && \
    mkdir -p $BUILDFOLDER && \
    cd $BUILDFOLDER && \
    cmake \
      -DENABLE_TESTS=$ENABLE_TESTS \
      -DCMAKE_C_COMPILER="$CC" \
      -DCMAKE_CXX_COMPILER="$CXX" \
      -DCMAKE_C_FLAGS="$CFLAGS" \
      -DCMAKE_CXX_FLAGS="$CXXFLAGS" \
      -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
      -DBUILD_SHARED_LIBS=OFF \
      -DAMCL_CURVE=BN254 \
      $SCRIPTPATH/core \
    && \
    VERBOSE=1 make
