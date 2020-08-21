FROM raspbian/fpixel

USER root

RUN apt-get purge -y libreoffice*
RUN apt-get clean
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get dist-upgrade -y
RUN apt-get autoremove -y

# Dependencies

RUN apt-get install -y devscripts debhelper cmake libldap2-dev libgtkmm-3.0-dev libarchive-dev \
                        libcurl4-openssl-dev intltool
RUN apt-get install -y build-essential cmake pkg-config libjpeg-dev libtiff5-dev libjasper-dev \
                        libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
                        libxvidcore-dev libx264-dev libgtk2.0-dev libgtk-3-dev \
                        libatlas-base-dev libblas-dev libeigen{2,3}-dev liblapack-dev \
                        gfortran \
                        python2.7-dev python3-dev python-pip python3-pip python python3
RUN pip2 install -U pip
RUN pip3 install -U pip
RUN pip2 install numpy
RUN pip3 install numpy

# Python dependencies

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install numpy

# OpenCV building script

WORKDIR /
ENV OPENCV_VERSION=4.1.2
ADD build.sh ./build.sh
RUN ./build.sh