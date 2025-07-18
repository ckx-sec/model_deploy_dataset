# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.28

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /app

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /app/build_clang_debug

# Include any dependencies generated for this target.
include examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/compiler_depend.make

# Include the progress variables for this target.
include examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/progress.make

# Include the compile flags for this target's objects.
include examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/flags.make

examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.o: examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/flags.make
examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.o: /app/examples/ncnn/yolov5_detector_ncnn.cpp
examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.o: examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/app/build_clang_debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.o"
	cd /app/build_clang_debug/examples/ncnn && /usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.o -MF CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.o.d -o CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.o -c /app/examples/ncnn/yolov5_detector_ncnn.cpp

examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.i"
	cd /app/build_clang_debug/examples/ncnn && /usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /app/examples/ncnn/yolov5_detector_ncnn.cpp > CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.i

examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.s"
	cd /app/build_clang_debug/examples/ncnn && /usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /app/examples/ncnn/yolov5_detector_ncnn.cpp -o CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.s

# Object files for target yolov5_detector_ncnn
yolov5_detector_ncnn_OBJECTS = \
"CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.o"

# External object files for target yolov5_detector_ncnn
yolov5_detector_ncnn_EXTERNAL_OBJECTS =

bin/yolov5_detector_ncnn: examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/yolov5_detector_ncnn.cpp.o
bin/yolov5_detector_ncnn: examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/build.make
bin/yolov5_detector_ncnn: src/libmodel_deploy_dataset_lib.so
bin/yolov5_detector_ncnn: /usr/lib/aarch64-linux-gnu/libopencv_highgui.so.4.2.0
bin/yolov5_detector_ncnn: /app/third_party/ncnn/lib/libncnn.so
bin/yolov5_detector_ncnn: /usr/lib/aarch64-linux-gnu/libopencv_videoio.so.4.2.0
bin/yolov5_detector_ncnn: /usr/lib/aarch64-linux-gnu/libopencv_imgcodecs.so.4.2.0
bin/yolov5_detector_ncnn: /usr/lib/aarch64-linux-gnu/libopencv_imgproc.so.4.2.0
bin/yolov5_detector_ncnn: /usr/lib/aarch64-linux-gnu/libopencv_core.so.4.2.0
bin/yolov5_detector_ncnn: examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/app/build_clang_debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../../bin/yolov5_detector_ncnn"
	cd /app/build_clang_debug/examples/ncnn && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/yolov5_detector_ncnn.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/build: bin/yolov5_detector_ncnn
.PHONY : examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/build

examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/clean:
	cd /app/build_clang_debug/examples/ncnn && $(CMAKE_COMMAND) -P CMakeFiles/yolov5_detector_ncnn.dir/cmake_clean.cmake
.PHONY : examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/clean

examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/depend:
	cd /app/build_clang_debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /app /app/examples/ncnn /app/build_clang_debug /app/build_clang_debug/examples/ncnn /app/build_clang_debug/examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : examples/ncnn/CMakeFiles/yolov5_detector_ncnn.dir/depend

