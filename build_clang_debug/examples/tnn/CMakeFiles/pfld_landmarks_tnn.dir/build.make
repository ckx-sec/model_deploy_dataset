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
include examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/compiler_depend.make

# Include the progress variables for this target.
include examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/progress.make

# Include the compile flags for this target's objects.
include examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/flags.make

examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.o: examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/flags.make
examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.o: /app/examples/tnn/pfld_landmarks_tnn.cpp
examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.o: examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/app/build_clang_debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.o"
	cd /app/build_clang_debug/examples/tnn && /usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.o -MF CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.o.d -o CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.o -c /app/examples/tnn/pfld_landmarks_tnn.cpp

examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.i"
	cd /app/build_clang_debug/examples/tnn && /usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /app/examples/tnn/pfld_landmarks_tnn.cpp > CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.i

examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.s"
	cd /app/build_clang_debug/examples/tnn && /usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /app/examples/tnn/pfld_landmarks_tnn.cpp -o CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.s

# Object files for target pfld_landmarks_tnn
pfld_landmarks_tnn_OBJECTS = \
"CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.o"

# External object files for target pfld_landmarks_tnn
pfld_landmarks_tnn_EXTERNAL_OBJECTS =

bin/pfld_landmarks_tnn: examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/pfld_landmarks_tnn.cpp.o
bin/pfld_landmarks_tnn: examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/build.make
bin/pfld_landmarks_tnn: /app/third_party/tnn/lib/libTNN.so
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_stitching.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_aruco.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_bgsegm.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_bioinspired.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_ccalib.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_dnn_objdetect.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_dnn_superres.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_dpm.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_face.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_freetype.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_fuzzy.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_hdf.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_hfs.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_img_hash.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_line_descriptor.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_quality.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_reg.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_rgbd.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_saliency.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_shape.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_stereo.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_structured_light.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_superres.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_surface_matching.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_tracking.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_videostab.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_viz.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_xobjdetect.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_xphoto.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_highgui.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_datasets.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_plot.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_text.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_dnn.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_ml.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_phase_unwrapping.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_optflow.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_ximgproc.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_video.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_videoio.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_imgcodecs.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_objdetect.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_calib3d.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_features2d.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_flann.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_photo.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_imgproc.so.4.2.0
bin/pfld_landmarks_tnn: /usr/lib/aarch64-linux-gnu/libopencv_core.so.4.2.0
bin/pfld_landmarks_tnn: examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/app/build_clang_debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../../bin/pfld_landmarks_tnn"
	cd /app/build_clang_debug/examples/tnn && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/pfld_landmarks_tnn.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/build: bin/pfld_landmarks_tnn
.PHONY : examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/build

examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/clean:
	cd /app/build_clang_debug/examples/tnn && $(CMAKE_COMMAND) -P CMakeFiles/pfld_landmarks_tnn.dir/cmake_clean.cmake
.PHONY : examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/clean

examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/depend:
	cd /app/build_clang_debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /app /app/examples/tnn /app/build_clang_debug /app/build_clang_debug/examples/tnn /app/build_clang_debug/examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : examples/tnn/CMakeFiles/pfld_landmarks_tnn.dir/depend

