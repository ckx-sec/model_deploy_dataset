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
include examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/depend.make

# Include the progress variables for this target.
include examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/progress.make

# Include the compile flags for this target's objects.
include examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/flags.make

examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/ssrnet_age.cpp.o: examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/flags.make
examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/ssrnet_age.cpp.o: ../examples/onnxruntime/ssrnet_age.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/ssrnet_age.cpp.o"
	cd /app/build/examples/onnxruntime && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/ssrnet_age_onnxruntime.dir/ssrnet_age.cpp.o -c /app/examples/onnxruntime/ssrnet_age.cpp

examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/ssrnet_age.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/ssrnet_age_onnxruntime.dir/ssrnet_age.cpp.i"
	cd /app/build/examples/onnxruntime && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /app/examples/onnxruntime/ssrnet_age.cpp > CMakeFiles/ssrnet_age_onnxruntime.dir/ssrnet_age.cpp.i

examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/ssrnet_age.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/ssrnet_age_onnxruntime.dir/ssrnet_age.cpp.s"
	cd /app/build/examples/onnxruntime && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /app/examples/onnxruntime/ssrnet_age.cpp -o CMakeFiles/ssrnet_age_onnxruntime.dir/ssrnet_age.cpp.s

# Object files for target ssrnet_age_onnxruntime
ssrnet_age_onnxruntime_OBJECTS = \
"CMakeFiles/ssrnet_age_onnxruntime.dir/ssrnet_age.cpp.o"

# External object files for target ssrnet_age_onnxruntime
ssrnet_age_onnxruntime_EXTERNAL_OBJECTS =

bin/ssrnet_age_onnxruntime: examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/ssrnet_age.cpp.o
bin/ssrnet_age_onnxruntime: examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/build.make
bin/ssrnet_age_onnxruntime: src/libmodel_deploy_dataset_lib.so
bin/ssrnet_age_onnxruntime: /usr/lib/aarch64-linux-gnu/libopencv_highgui.so.4.2.0
bin/ssrnet_age_onnxruntime: ../third_party/onnxruntime/lib/libonnxruntime.so
bin/ssrnet_age_onnxruntime: /usr/lib/aarch64-linux-gnu/libopencv_videoio.so.4.2.0
bin/ssrnet_age_onnxruntime: /usr/lib/aarch64-linux-gnu/libopencv_imgcodecs.so.4.2.0
bin/ssrnet_age_onnxruntime: /usr/lib/aarch64-linux-gnu/libopencv_imgproc.so.4.2.0
bin/ssrnet_age_onnxruntime: /usr/lib/aarch64-linux-gnu/libopencv_core.so.4.2.0
bin/ssrnet_age_onnxruntime: examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../../bin/ssrnet_age_onnxruntime"
	cd /app/build/examples/onnxruntime && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ssrnet_age_onnxruntime.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/build: bin/ssrnet_age_onnxruntime

.PHONY : examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/build

examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/clean:
	cd /app/build/examples/onnxruntime && $(CMAKE_COMMAND) -P CMakeFiles/ssrnet_age_onnxruntime.dir/cmake_clean.cmake
.PHONY : examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/clean

examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/depend:
	cd /app/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /app /app/examples/onnxruntime /app/build /app/build/examples/onnxruntime /app/build/examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/onnxruntime/CMakeFiles/ssrnet_age_onnxruntime.dir/depend

