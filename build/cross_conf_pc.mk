#CROSS_OPENCV_INC_PATH=/home/hjpark/works/opencv/opencv_lib/x64_linux_gnu/include
#CROSS_OPENCV_LIB_PATH=/home/hjpark/works/opencv/opencv_lib/x64_linux_gnu/lib
#CROSS_OPENCV_INC_PATH='/usr/local/include'
#CROSS_OPENCV_LIB_PATH='/usr/local/lib/i386-linux-gnu'
#CROSS_BOOST_INC_PATH='./'
#CROSS_BOOST_LIB_PATH='/.'

CROSS_OPENCV_CFLAG = `pkg-config opencv4 --cflags`
CROSS_OPENCV_LIBS = `pkg-config opencv4 --libs`

CROSS_CXXFLAGS = 
CROSS_INCDIRS = 
CROSS_SRCDIRS = 
CROSS_LIBS =

CROSS_CC = gcc
CROSS_LD = gcc

#CROSS_AR = ar
#CROSS_PREFIX=
#CROSS_DEVICE_FLAGS=
#CROSS_SYSROOT= 