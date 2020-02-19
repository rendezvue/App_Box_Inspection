CROSSENV_PATH=/home/hjpark/works/ERVS/ERVS/BuildSDK/Ensemble_M
TOOLCHAIN_PATH=$(CROSSENV_PATH)/gcc/bin
SYSROOT_PATH=$(CROSSENV_PATH)/rootfs

#CC = $(TOOLCHAIN_PATH)/aarch64-linux-gnu-g++
#LD = $(TOOLCHAIN_PATH)/aarch64-linux-gnu-ld
#AR = $(TOOLCHAIN_PATH)/aarch64-linux-gnu-ar

TOPDIR=$(shell pwd)/../DeviceHAL

SYSROOT_LIB_PATH = -L$(SYSROOT_PATH)/lib/aarch64-linux-gnu

BOOST_LIB_PATH = -L$(SYSROOT_PATH)/usr/lib/aarch64-linux-gnu
BOOST_INC_PATH = -I$(SYSROOT_PATH)/usr/include

OPENCV_LIB_PATH = -L$(SYSROOT_PATH)/usr/local/lib
OPENCV_INC_PATH = -I$(SYSROOT_PATH)/usr/local/include


LIBS_OPENCV += -lopencv_stitching -lopencv_superres -lopencv_videostab -lopencv_aruco -lopencv_bgsegm -lopencv_bioinspired -lopencv_ccalib -lopencv_cvv -lopencv_dnn_objdetect -lopencv_dpm -lopencv_face -lopencv_photo -lopencv_freetype -lopencv_fuzzy -lopencv_hfs -lopencv_img_hash -lopencv_line_descriptor -lopencv_optflow -lopencv_reg -lopencv_rgbd -lopencv_saliency -lopencv_stereo -lopencv_structured_light -lopencv_phase_unwrapping -lopencv_surface_matching -lopencv_tracking -lopencv_datasets -lopencv_text -lopencv_dnn -lopencv_plot -lopencv_xfeatures2d -lopencv_shape -lopencv_video -lopencv_ml -lopencv_ximgproc -lopencv_calib3d -lopencv_features2d -lopencv_highgui -lopencv_videoio -lopencv_flann -lopencv_xobjdetect -lopencv_imgcodecs -lopencv_objdetect -lopencv_xphoto -lopencv_imgproc -lopencv_core -ldl -lm -lpthread -lrt

LIBS_BOOST += -lboost_system -lboost_thread -lboost_filesystem

RK3399_LINUX_INC = -I/home/hjpark/works/rockchip/rk3399_nanopc-t4/nanopc-t4/kernel-rockchip/include
RK3399_VPU_INC = -I$(TOPDIR)/HAL_Vpu/ensemble_m/linux-rga
RK3399_VPU_LIB = -L$(SYSROOT_PATH)/opt/librga_linux/lib -lrga

INC_CAMDRIVER = -I$(TOPDIR) \
				-I$(TOPDIR)/HAL_Cam \
				-I$(TOPDIR)/HAL_Cam/ensemble_m/ov4689 \
				-I$(TOPDIR)/HAL_Cam/ensemble_m/ov13850 \
				-I$(TOPDIR)/HAL_Led \
				-I$(TOPDIR)/HAL_Led/ensemble_m \
				-I$(TOPDIR)/HAL_Vpu \
				-I$(TOPDIR)/HAL_Vpu/ensemble_m \
				$(RK3399_VPU_INC) \
				-I$(TOPDIR)/HAL_Cam/ensemble_m/ov13850/linux

SRC_CAMDRIVER = $(TOPDIR) \
				$(TOPDIR)/HAL_Cam \
				$(TOPDIR)/HAL_Cam/ensemble_m/ov4689 \
				$(TOPDIR)/HAL_Cam/ensemble_m/ov13850 \
				$(TOPDIR)/HAL_Led \
				$(TOPDIR)/HAL_Led/ensemble_m \
				$(TOPDIR)/HAL_Vpu \
				$(TOPDIR)/HAL_Vpu/ensemble_m


HAL_SRCDIR = $(SRC_CAMDRIVER)

ifeq ($(mode), test)
HAL_SRCDIR += $(TOPDIR)/HalTest
endif

#CROSS_INC_PATH = $(OPENCV_INC_PATH) $(BOOST_INC_PATH) $(INC_CAMDRIVER)
CROSS_INC_PATH = $(INC_CAMDRIVER)
CROSS_SRC_PATH = $(HAL_SRCDIR)

#CROSS_CFLAGS = $(CROSS_INC_PATH)
CROSS_CFLAGS = $(CROSS_INC_PATH) 

CROSS_CFLAGS += -Wl,-rpath,$(SYSROOT_PATH)/lib/aarch64-linux-gnu
CROSS_CFLAGS += -Wl,-rpath,$(SYSROOT_PATH)/usr/lib/aarch64-linux-gnu
CROSS_CFLAGS += -Wl,-rpath,$(SYSROOT_PATH)/usr/rk3399-libs/lib64

CROSS_LIB = $(SYSROOT_LIB_PATH) 
CROSS_LIB += $(OPENCV_LIB_PATH) $(BOOST_LIB_PATH) $(LIBS_BOOST) $(LIBS_OPENCV)

#이정도만 해서 최상위 MAKEFILE에 플래그 겹치지 않게 넘겨주자

######## 위를 종합하여 아래의 플래그들만 SET 하면 됨##########

CROSS_OPENCV_INC_PATH=$(SYSROOT_PATH)/usr/local/include
CROSS_OPENCV_LIB_PATH=$(SYSROOT_PATH)/usr/local/lib
CROSS_BOOST_INC_PATH=$(SYSROOT_PATH)/usr/include
CROSS_BOOST_LIB_PATH=$(SYSROOT_PATH)/usr/lib/aarch64-linux-gnu
CROSS_OPENCV_DEP_LIB=$(LIBS_OPENCV)
CROSS_VPU_LIB=$(RK3399_VPU_LIB)

CROSS_CC = $(TOOLCHAIN_PATH)/aarch64-linux-gnu-g++
CROSS_LD = $(TOOLCHAIN_PATH)/aarch64-linux-gnu-ld
CROSS_AR = $(TOOLCHAIN_PATH)/aarch64-linux-gnu-ar

CROSS_PREFIX=arm64_
CROSS_DEVICE_FLAGS=-DEYEDEA_SVM_DEVICE_CAM

CROSS_SYSROOT= --sysroot=$(SYSROOT_PATH)
