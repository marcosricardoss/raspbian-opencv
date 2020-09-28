FROM raspbian/fpixel

USER root

RUN apt-get remove -y --purge python3 
RUN apt-get purge -y libreoffice*
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y
RUN apt-get autoremove -y

# Dependencies

RUN apt-get install -y \
  build-essential \
  cmake \  
  debhelper \
  devscripts \
  gfortran tk-dev \
  intltool \
  libarchive-dev \
  libatlas-base-dev \
  libavcodec-dev \
  libavformat-dev \
  libblas-dev \
  libcurl4-openssl-dev \
  libeigen2-dev \
  libeigen3-dev \
  libgtk-3-dev \
  libgtk2.0-dev \
  libgtkmm-3.0-dev \
  libjasper-dev \
  libjpeg-dev \
  liblapack-dev \
  libldap2-dev \
  libswscale-dev \
  libtiff5-dev \
  libv4l-dev \
  libx264-dev \
  libxvidcore-dev \
  pkg-config \  
  libraspberrypi-bin

# Python 3.8 dependencies

RUN apt-get install -y \
  libbz2-dev \
  libdb5.3-dev \
  libexpat1-dev \
  libffi-dev \
  libgdbm-dev \
  liblzma-dev \
  libncurses5-dev \
  libncursesw5-dev \
  libreadline6-dev \
  libsqlite3-dev \
  libssl-dev \
  tar \
  tk-dev \
  vim \
  wget \
  zlib1g-dev

# Python3.8 install script
WORKDIR /
ENV PYTHON_VERSION=3.8.0
ADD python-installer.sh ./python-installer.sh
RUN ./python-installer.sh

# Python dependencies for OpenCV building
RUN pip3.8 install -U pip
RUN pip3.8 install numpy

# OpenCV install script
WORKDIR /
ENV OPENCV_VERSION=4.1.2
ADD opencv-installer.sh ./opencv-installer.sh
RUN ./opencv-installer.sh