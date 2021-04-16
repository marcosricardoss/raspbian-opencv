#!/usr/bin/env bash
set -ex

mkdir -p opencv && pushd opencv

wget -O "opencv-${OPENCV_VERSION}.tar.gz" "https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.tar.gz"
wget -O "opencv_contrib-${OPENCV_VERSION}.tar.gz" "https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.tar.gz"
tar -xvf "opencv-${OPENCV_VERSION}.tar.gz"
tar -xvf "opencv_contrib-${OPENCV_VERSION}.tar.gz"

pushd opencv-$OPENCV_VERSION
mkdir -p build
pushd build

NUM_JOBS=$(nproc)

# -D ENABLE_PRECOMPILED_HEADERS=OFF
# is a fix for https://github.com/opencv/opencv/issues/14868

# -D OPENCV_EXTRA_EXE_LINKER_FLAGS=-latomic
# is a fix for https://github.com/opencv/opencv/issues/15192

cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-$OPENCV_VERSION/modules \
      -D OPENCV_ENABLE_NONFREE=ON \
      -D BUILD_PERF_TESTS=OFF \
      -D BUILD_TESTS=OFF \
      -D BUILD_DOCS=ON \
      -D BUILD_EXAMPLES=ON \
      -D ENABLE_PRECOMPILED_HEADERS=OFF \
      -D WITH_TBB=ON \
      -D WITH_OPENMP=ON \
      -D ENABLE_NEON=ON \
      -D ENABLE_VFPV3=ON \
      -D OPENCV_GENERATE_PKGCONFIG=YES \
      -D OPENCV_EXTRA_EXE_LINKER_FLAGS=-latomic \
      -D PYTHON3_EXECUTABLE=$(which python3.8) \
      ..
make -j "$NUM_JOBS"
make install
popd; popd