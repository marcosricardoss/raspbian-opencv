#!/usr/bin/env bash
set -ex

wget -O "python-${PYTHON_VERSION}.tar.gz" "https://www.python.org/ftp/python/3.8.0/Python-${PYTHON_VERSION}.tgz"
tar -xvf "python-${PYTHON_VERSION}.tar.gz"
pushd python-$PYTHON_VERSION

MEM="$(free -m | awk /Mem:/'{print $2}')"  # Total memory in MB
# RPI 4 with 4GB RAM is actually 3906MB RAM after factoring in GPU RAM split.
# We're probably good to go with `-j $(nproc)` with 3GB or more RAM.
if [[ $MEM -ge 3000 ]]; then
  NUM_JOBS=$(nproc)
else
  NUM_JOBS=1 # Earlier versions of the Pi don't have sufficient RAM to support compiling with multiple jobs.
fi

./configure --enable-optimizations
make -j "$NUM_JOBS"
make altinstall

popd; popd