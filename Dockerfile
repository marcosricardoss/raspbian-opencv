FROM jumidlej/raspios-buster

USER root

RUN apt-get purge -y libreoffice*
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y
RUN apt-get autoremove -y

# OpenCV dependencies

RUN apt-get install -y devscripts debhelper cmake libldap2-dev libgtkmm-3.0-dev libarchive-dev \
                        libcurl4-openssl-dev intltool
RUN apt-get install -y build-essential cmake pkg-config libjpeg-dev libtiff5-dev libjasper-dev \
                        libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
                        libxvidcore-dev libx264-dev libgtk2.0-dev libgtk-3-dev \
                        libatlas-base-dev libblas-dev libeigen2-dev libeigen3-dev liblapack-dev \
                        gfortran \
                        python2.7-dev python3-dev python-pip python3-pip python python3

# Python dependencies

RUN pip3 install -U pip
RUN pip3 install numpy

# Tensorflow dependencies

RUN apt-get install -y libhdf5-dev libc-ares-dev libeigen3-dev gcc gfortran python-dev libgfortran5 \
                        libatlas3-base libatlas-base-dev libopenblas-dev libopenblas-base libblas-dev \
                        liblapack-dev cython libatlas-base-dev openmpi-bin libopenmpi-dev python3-dev python3-venv
RUN pip3 install keras_applications==1.0.8 --no-deps
RUN pip3 install keras_preprocessing==1.1.0 --no-deps
RUN pip3 install h5py==2.9.0
RUN pip3 install pybind11
RUN pip3 install -U --user six wheel mock
ADD "https://raw.githubusercontent.com/PINTO0309/Tensorflow-bin/master/tensorflow-2.2.0-cp37-cp37m-linux_armv7l_download.sh" ./tensorflow-2.2.0-cp37-cp37m-linux_armv7l_download.sh
RUN sh ./tensorflow-2.2.0-cp37-cp37m-linux_armv7l_download.sh
RUN pip3 uninstall tensorflow
RUN pip3 install tensorflow-2.2.0-cp37-cp37m-linux_armv7l.whl

# Object detection dependencies

RUN pip3 install numpy==1.18.2
RUN pip3 install scipy==1.4.1
RUN pip3 install wget>=3.2
RUN pip3 install seaborn==0.10.0
RUN pip3 install tqdm==4.43.0
RUN pip3 install pandas
RUN pip3 install awscli
RUN pip3 install urllib3

# OpenCV building script

WORKDIR /
ENV OPENCV_VERSION=4.1.2
ADD build.sh ./build.sh
RUN ./build.sh