# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /app

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /app/build

# Include any dependencies generated for this target.
include examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/depend.make

# Include the progress variables for this target.
include examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/progress.make

# Include the compile flags for this target's objects.
include examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/flags.make

examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/fsanet_headpose.cpp.o: examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/flags.make
examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/fsanet_headpose.cpp.o: ../examples/onnxruntime/fsanet_headpose.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/fsanet_headpose.cpp.o"
	cd /app/build/examples/onnxruntime && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/fsanet_headpose.dir/fsanet_headpose.cpp.o -c /app/examples/onnxruntime/fsanet_headpose.cpp

examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/fsanet_headpose.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/fsanet_headpose.dir/fsanet_headpose.cpp.i"
	cd /app/build/examples/onnxruntime && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /app/examples/onnxruntime/fsanet_headpose.cpp > CMakeFiles/fsanet_headpose.dir/fsanet_headpose.cpp.i

examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/fsanet_headpose.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/fsanet_headpose.dir/fsanet_headpose.cpp.s"
	cd /app/build/examples/onnxruntime && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /app/examples/onnxruntime/fsanet_headpose.cpp -o CMakeFiles/fsanet_headpose.dir/fsanet_headpose.cpp.s

# Object files for target fsanet_headpose
fsanet_headpose_OBJECTS = \
"CMakeFiles/fsanet_headpose.dir/fsanet_headpose.cpp.o"

# External object files for target fsanet_headpose
fsanet_headpose_EXTERNAL_OBJECTS =

bin/fsanet_headpose: examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/fsanet_headpose.cpp.o
bin/fsanet_headpose: examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/build.make
bin/fsanet_headpose: src/libmodel_deploy_dataset_lib.so
bin/fsanet_headpose: /usr/lib/aarch64-linux-gnu/libopencv_highgui.so.4.2.0
bin/fsanet_headpose: ../third_party/onnxruntime/lib/libonnxruntime.so
bin/fsanet_headpose: /usr/lib/aarch64-linux-gnu/libopencv_videoio.so.4.2.0
bin/fsanet_headpose: /usr/lib/aarch64-linux-gnu/libopencv_imgcodecs.so.4.2.0
bin/fsanet_headpose: /usr/lib/aarch64-linux-gnu/libopencv_imgproc.so.4.2.0
bin/fsanet_headpose: /usr/lib/aarch64-linux-gnu/libopencv_core.so.4.2.0
bin/fsanet_headpose: examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../../bin/fsanet_headpose"
	cd /app/build/examples/onnxruntime && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/fsanet_headpose.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/build: bin/fsanet_headpose

.PHONY : examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/build

examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/clean:
	cd /app/build/examples/onnxruntime && $(CMAKE_COMMAND) -P CMakeFiles/fsanet_headpose.dir/cmake_clean.cmake
.PHONY : examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/clean

examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/depend:
	cd /app/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /app /app/examples/onnxruntime /app/build /app/build/examples/onnxruntime /app/build/examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/onnxruntime/CMakeFiles/fsanet_headpose.dir/depend

