-include cross_conf.mk

INCDIRS = -I./ \
		-I../ \
		-I../include \
		$(CROSS_INCDIRS)
		
#BOOST_INC_PATH='../'
#BOOST_LIB_PATH='/.'

OPENCV_CFLAG = $(CROSS_OPENCV_CFLAG)
OPENCV_LIBS = $(CROSS_OPENCV_LIBS)

TARGET = RDV_App_Box_Inspection
VERSIONNUM = commitver

CC = $(CROSS_CC)
LD = $(CROSS_LD)

#CXXFLAGS  = $(OPENCV_CFLAG) -I$(BOOST_INC_PATH) $(INCDIRS)
CXXFLAGS  = $(OPENCV_CFLAG) $(INCDIRS)
#CXXFLAGS += -O3 -g3 -Wall -std=c++11 -fopenmp -openmp
CXXFLAGS += -O3 -Wall -std=c++11 -fopenmp -openmp
CXXFLAGS += -DRENDEZVUE_LOG $(CROSS_DEVICE_FLAGS)
CXXFLAGS += $(CROSS_CXXFLAGS)


#LIBS = -L$(BOOST_LIB_PATH) -Xlinker --start-group -lpthread -ldl -lm -lrt -lc -lstdc++ -lboost_system -lboost_thread -lboost_filesystem -lboost_regex -lboost_date_time -lgomp -lstdc++fs -Xlinker --end-group $(OPENCV_LIBS)
LIBS = -Xlinker --start-group -lpthread -ldl -lm -lrt -lc -lstdc++ -lboost_system -lboost_thread -lboost_filesystem -lboost_regex -lboost_date_time -lboost_program_options -lgomp -lstdc++fs -lzbar -Xlinker --end-group $(OPENCV_LIBS)
LIBS += $(CROSS_LIBS)

SRCDIRS		= ../ \
			../src \
			../src/RendezvueSensor \
			../src/RendezvueCamera \
			../src/RendezvueLedBar \
			../src/RendezvueLight \
			../src/RendezvueVision \
			$(CROSS_SRCDIRS)
			
			
VPATH = . $(SRCDIRS)

SRCS = $(foreach dir, . $(SRCDIRS),$(wildcard $(dir)/*.cpp))

OBJS = $(SRCS:.cpp=.o)
OBJS := $(notdir $(OBJS))
#$(OBJS) := $(patsubst %.o,obj/%.o,$(OBJS))
#OBJ = $(subst src/,obj/,$(subst .cpp,.o,$(SRCS)))
#OBJS = $(SRCS:.cpp=.o)
#OBJS := $(join $(addsuffix ./obj/,$(dir $(SRCS))),$(notdir $(SRCS)))
#OBJS := $(notdir $(OBJS))
#OBJS := $(addsuffix , ./obj/ $(OBJS))
#OBJS = $(subst src/,bin/,$(subst .cpp,.o,$(SRC)))

GITVERSION = "const char* version=\"ensemble_version_$(shell git rev-parse HEAD)\";"

all: $(TARGET)

$(VERSIONNUM): 
	echo $(GITVERSION) > VersionInfo.h

$(TARGET) : $(OBJS)
	-rm -f $(TARGET)
	-rm -f ../$(TARGET)
	$(CC) $(CXXFLAGS) $^ -o $(TARGET) $(LIBS) $(CROSS_SYSROOT)
	-mv ./$(TARGET) ../

%.o:%.cpp
	$(CC) -Wall $(CXXFLAGS) -c $< -o $@ $(CROSS_SYSROOT)

clean:
	-rm -rf $(OBJS)
	-rm -f $(TARGET)
	-rm -f ../$(TARGET)
	-rm -f depend
	-rm VersionInfo.h 

depend: $(VERSIONNUM)
	$(SRCS) 
	$(CC) -M $(CXXFLAGS) $^ > $@ 

-include depend

#depend: .depend
#
#.depend: $(SRCS) $(VERSIONNUM)
#	rm -f ./.depend
#	$(CC) $(CXXFLAGS) -MM $^ > $(notdir $@) -MF  ./.depend;
#	echo "HAHAHAH = " $(CC) $(CXXFLAGS) -MM $^ > $(notdir $@) -MF  ./.depend;
#	#$(CC) $(CFLAGS) -MM $^ -MF  ./.depend;
#
#-include .depend
