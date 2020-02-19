CROSSENV_PATH=/home/hjpark/works/ensemble/BuildSDK/Ensemble_RP4
TOOLCHAIN_PATH=$(CROSSENV_PATH)/cross-pi-gcc-8.3.0-2/bin
SYSROOT_PATH=$(CROSSENV_PATH)/rootfs1

#CC = $(TOOLCHAIN_PATH)/aarch64-linux-gnu-g++
#LD = $(TOOLCHAIN_PATH)/aarch64-linux-gnu-ld
#AR = $(TOOLCHAIN_PATH)/aarch64-linux-gnu-ar

TOPDIR=$(shell pwd)/../../DeviceHAL

SYSROOT_LIB_PATH = -L$(SYSROOT_PATH)/lib/arm-linux-gnueabihf

BOOST_LIB_PATH = -L$(SYSROOT_PATH)/usr/lib/arm-linux-gnueabihf
BOOST_INC_PATH = -I$(SYSROOT_PATH)/usr/include

OPENCV_LIB_PATH = -L$(SYSROOT_PATH)/usr/local/lib
OPENCV_INC_PATH = -I$(SYSROOT_PATH)/usr/local/include/opencv4


LIBS_OPENCV += -lopencv_stitching -lopencv_superres -lopencv_videostab -lopencv_aruco -lopencv_bgsegm -lopencv_bioinspired -lopencv_ccalib -lopencv_dnn_objdetect -lopencv_dpm -lopencv_face -lopencv_photo -lopencv_freetype -lopencv_fuzzy -lopencv_hfs -lopencv_img_hash -lopencv_line_descriptor -lopencv_optflow -lopencv_reg -lopencv_rgbd -lopencv_saliency -lopencv_stereo -lopencv_structured_light -lopencv_phase_unwrapping -lopencv_surface_matching -lopencv_tracking -lopencv_datasets -lopencv_text -lopencv_dnn -lopencv_plot -lopencv_xfeatures2d -lopencv_shape -lopencv_video -lopencv_ml -lopencv_ximgproc -lopencv_calib3d -lopencv_features2d -lopencv_highgui -lopencv_videoio -lopencv_flann -lopencv_xobjdetect -lopencv_imgcodecs -lopencv_objdetect -lopencv_xphoto -lopencv_imgproc -lopencv_core -ldl -lm -lpthread -lrt


RP4_LIB_PATH = -L$(SYSROOT_PATH)/opt/vc/lib/
LIBS_RP4 += -lmmal_core -lmmal_util -lmmal_vc_client -lbcm_host -lvcos -lvchiq_arm -lvcsm -lraspicam_cv -lraspicam -larducam_mipicamera -lmmal -lmmal_components -lcontainers

INC_CAMDRIVER = -I$(TOPDIR) \
				-I$(TOPDIR)/HAL_Cam \
				-I$(TOPDIR)/HAL_Cam/rp4/b0122 \
				-I$(TOPDIR)/HAL_Cam/rp4/picamera_lib/include \
				-I$(TOPDIR)/HAL_Cam/rp4/ov9281 \
				-I$(TOPDIR)/HAL_Cam/rp4/ov9281/MIPI_Camera/RPI \
				-I$(TOPDIR)/HAL_Led \
				-I$(TOPDIR)/HAL_Led/rp4 \
				-I$(TOPDIR)/HAL_Sensor \
				-I$(TOPDIR)/HAL_Sensor/neuromeka \
				-I$(TOPDIR)/HAL_Sensor/neuromeka/IndyDCP \
				-I$(TOPDIR)/HAL_Sensor/rp4_sensor \
				-I$(TOPDIR)/HAL_Sensor/rp4_sensor/Easy_Interface

SRC_CAMDRIVER = $(TOPDIR) \
				$(TOPDIR)/HAL_Cam \
				$(TOPDIR)/HAL_Cam/rp4/b0122 \
				$(TOPDIR)/HAL_Cam/rp4/ov9281 \
				$(TOPDIR)/HAL_Led \
				$(TOPDIR)/HAL_Led/rp4 \
				$(TOPDIR)/HAL_Sensor \
				$(TOPDIR)/HAL_Sensor/neuromeka \
				$(TOPDIR)/HAL_Sensor/neuromeka/IndyDCP \
				$(TOPDIR)/HAL_Sensor/rp4_sensor \
				$(TOPDIR)/HAL_Sensor/rp4_sensor/Easy_Interface

HAL_SRCDIR = $(SRC_CAMDRIVER)

CROSS_INC_PATH = $(INC_CAMDRIVER)
CROSS_SRC_PATH = $(HAL_SRCDIR)

CROSS_CFLAGS = $(CROSS_INC_PATH) 

CROSS_CFLAGS += -Wl,-rpath,$(SYSROOT_PATH)/lib/arm-linux-gnueabihf
CROSS_CFLAGS += -Wl,-rpath,$(SYSROOT_PATH)/usr/lib/arm-linux-gnueabihf

CROSS_LIBS = $(SYSROOT_LIB_PATH) 
CROSS_LIBS += $(OPENCV_LIB_PATH) $(BOOST_LIB_PATH) $(LIBS_OPENCV) $(RP4_LIB_PATH) $(LIBS_RP4)

#이정도만 해서 최상위 MAKEFILE에 플래그 겹치지 않게 넘겨주자

######## 위를 종합하여 아래의 플래그들만 SET 하면 됨##########

CROSS_OPENCV_INC_PATH=$(SYSROOT_PATH)/usr/local/include/opencv4
CROSS_OPENCV_LIB_PATH=$(SYSROOT_PATH)/usr/local/lib
CROSS_BOOST_INC_PATH=$(SYSROOT_PATH)/usr/include
CROSS_BOOST_LIB_PATH=$(SYSROOT_PATH)/usr/lib/arm-linux-gnueabihf
CROSS_OPENCV_DEP_LIB=$(LIBS_OPENCV)
CROSS_ARM_LINUX= $(SYSROOT_PATH)/usr/include/arm-linux-gnueabihf


#=========================================
#CROSS_OPENCV_CFLAG = `pkg-config opencv4 --cflags`
CROSS_OPENCV_LIBS = $(CROSS_OPENCV_DEP_LIB)

#CROSS_CXXFLAGS = -march=armv6 -mfloat-abi=hard -mfpu=vfp $(CROSS_CFLAGS)   #라즈베리파이의 기본 compiler가 이 옵션을 사용중임.
#CROSS_CXXFLAGS = -march=armv8-a -mfloat-abi=hard -mfpu=neon-fp-armv8 $(CROSS_CFLAGS) 
CROSS_CXXFLAGS = -march=armv8-a -mfloat-abi=hard -mfpu=neon-fp-armv8 $(CROSS_CFLAGS) 
CROSS_CXXFLAGS +=  $(CROSS_CFLAGS) 
CROSS_INCDIRS = -I$(CROSS_OPENCV_INC_PATH) -I$(CROSS_BOOST_INC_PATH) -I$(CROSS_ARM_LINUX)
CROSS_SRCDIRS =  $(CROSS_SRC_PATH)
CROSS_LIBS += -L/home/hjpark/works/ensemble/BuildSDK/Ensemble_RP4/rootfs1/usr/lib \
			-L/home/hjpark/works/ensemble/BuildSDK/Ensemble_RP4/rootfs1/usr/lib/arm-linux-gnueabihf \
			-L/home/hjpark/works/ensemble/DeviceHAL/HAL_Cam/rp4/picamera_lib/lib
CROSS_SYSROOT= --sysroot=$(SYSROOT_PATH)

#CROSS_CC = $(TOOLCHAIN_PATH)/arm-linux-gnueabihf-gcc
#CROSS_LD = $(TOOLCHAIN_PATH)/arm-linux-gnueabihf-ld
#CROSS_AR = $(TOOLCHAIN_PATH)/arm-linux-gnueabihf-ar

CROSS_CC = arm-linux-gnueabihf-gcc
#CROSS_LD = $(TOOLCHAIN_PATH)/arm-linux-gnueabihf-ld
#CROSS_AR = $(TOOLCHAIN_PATH)/arm-linux-gnueabihf-ar

CROSS_DEVICE_FLAGS=-DRENDEZVUE_SVM_DEVICE_CAM
CROSS_PREFIX=arm_rp4_
