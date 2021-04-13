#!/usr/bin/env bash
set -ex

wget -O "python-${PYTHON_VERSION}.tar.gz" "https://www.python.org/ftp/python/3.8.0/Python-${PYTHON_VERSION}.tgz"
tar -xvf "python-${PYTHON_VERSION}.tar.gz"
# Troquei python por Python, estava dando erro no pushd para encontrar os arquivos
pushd Python-$PYTHON_VERSION

NUM_JOBS=$(nproc)

./configure --enable-optimizations
make -j "$NUM_JOBS"
make altinstall

popd