top_dir := ../
sdk_dir := $(top_dir)
install_dir = $(top_dir)/install

CXX = aarch64-linux-gnu-g++

INC_DIR = -I$(sdk_dir)/include/third_party/boost/include
INC_DIR += -I$(sdk_dir)/include/opencv/opencv4
INC_DIR += -I$(sdk_dir)/include/ffmpeg
INC_DIR += -I$(sdk_dir)/include/bmruntime
INC_DIR += -I$(sdk_dir)/include/bmlib
INC_DIR += -I$(sdk_dir)/include
INC_DIR += -I$(sdk_dir)
CXXFLAGS := -g -O2  -Wall -std=c++11 $(INC_DIR)
CXXFLAGS += -DBM_VPP_ENABLE


LDLIBS := -lbmrt -lbmlib -lbmcv -ldl \
	-lopencv_core -lopencv_imgproc -lopencv_imgcodecs -lopencv_videoio \
	-lbmvideo -lswresample -lswscale -lavformat -lavutil \
	-lboost_system -lboost_filesystem -lpthread -lbmjpuapi -lbmjpulite

LIB_DIR = -L$(sdk_dir)/lib/thirdparty/soc
LIB_DIR += -L$(sdk_dir)/lib/bmnn/soc
LIB_DIR += -L$(sdk_dir)/lib/opencv/soc -L$(sdk_dir)/lib/ffmpeg/soc -L$(sdk_dir)/lib/decode/soc
LDFLAGS = -Wl,-rpath=$(sdk_dir)/lib/bmnn/soc
LDFLAGS += -Wl,-rpath=$(sdk_dir)/lib/opencv/soc
LDFLAGS += -Wl,-rpath=$(sdk_dir)/lib/ffmpeg/soc
LDFLAGS += -Wl,-rpath=$(sdk_dir)/lib/decode/soc
LDFLAGS += $(LIB_DIR)

all: v5_test

v5_test: main.cpp yolov5.cpp
	$(CXX) $^ $(CXXFLAGS) $(LDLIBS) $(LDFLAGS) -o $@

clean:
	rm -f v5_test

