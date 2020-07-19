FROM raspbian/fpixel

USER root

RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y
RUN apt-get autoremove -y

# Dependencies

RUN apt-get install -y \
    build-essential \
    cmake \
    cmake \
    debhelper \
    devscripts \
    gfortran \
    intltool \
    libarchive-dev \
    libatlas-base-dev \
    libavcodec-dev \ 
    libavformat-dev \
    libblas-dev \
    libcurl4-openssl-dev \
    libeigen3-dev \
    libgtk-3-dev \
    libgtk2.0-dev \
    libgtkmm-3.0-dev \
    libjasper-dev \
    libjpeg-dev \
    liblapack-dev \
    libldap2-dev \
    libswscale-dev libv4l-dev \
    libtiff5-dev \
    libx264-dev \
    libxvidcore-dev \
    pkg-config \
    python3 \
    python3-dev \
    python3-pip

# Python dependencies

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install numpy

# OpenCV building script

WORKDIR /
ENV OPENCV_VERSION=4.1.2
ADD build.sh ./build.sh
RUN ./build.sh