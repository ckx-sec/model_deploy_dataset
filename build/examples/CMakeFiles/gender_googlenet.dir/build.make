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
include examples/CMakeFiles/gender_googlenet.dir/depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/gender_googlenet.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/gender_googlenet.dir/flags.make

examples/CMakeFiles/gender_googlenet.dir/gender_googlenet.cpp.o: examples/CMakeFiles/gender_googlenet.dir/flags.make
examples/CMakeFiles/gender_googlenet.dir/gender_googlenet.cpp.o: ../examples/gender_googlenet.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/CMakeFiles/gender_googlenet.dir/gender_googlenet.cpp.o"
	cd /app/build/examples && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/gender_googlenet.dir/gender_googlenet.cpp.o -c /app/examples/gender_googlenet.cpp

examples/CMakeFiles/gender_googlenet.dir/gender_googlenet.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/gender_googlenet.dir/gender_googlenet.cpp.i"
	cd /app/build/examples && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /app/examples/gender_googlenet.cpp > CMakeFiles/gender_googlenet.dir/gender_googlenet.cpp.i

examples/CMakeFiles/gender_googlenet.dir/gender_googlenet.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/gender_googlenet.dir/gender_googlenet.cpp.s"
	cd /app/build/examples && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /app/examples/gender_googlenet.cpp -o CMakeFiles/gender_googlenet.dir/gender_googlenet.cpp.s

# Object files for target gender_googlenet
gender_googlenet_OBJECTS = \
"CMakeFiles/gender_googlenet.dir/gender_googlenet.cpp.o"

# External object files for target gender_googlenet
gender_googlenet_EXTERNAL_OBJECTS =

bin/gender_googlenet: examples/CMakeFiles/gender_googlenet.dir/gender_googlenet.cpp.o
bin/gender_googlenet: examples/CMakeFiles/gender_googlenet.dir/build.make
bin/gender_googlenet: src/libmulti_engine_lib.so
bin/gender_googlenet: /usr/lib/aarch64-linux-gnu/libopencv_highgui.so.4.2.0
bin/gender_googlenet: ../third_party/onnxruntime/lib/libonnxruntime.so
bin/gender_googlenet: /usr/lib/aarch64-linux-gnu/libopencv_videoio.so.4.2.0
bin/gender_googlenet: /usr/lib/aarch64-linux-gnu/libopencv_imgcodecs.so.4.2.0
bin/gender_googlenet: /usr/lib/aarch64-linux-gnu/libopencv_imgproc.so.4.2.0
bin/gender_googlenet: /usr/lib/aarch64-linux-gnu/libopencv_core.so.4.2.0
bin/gender_googlenet: examples/CMakeFiles/gender_googlenet.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../bin/gender_googlenet"
	cd /app/build/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/gender_googlenet.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/gender_googlenet.dir/build: bin/gender_googlenet

.PHONY : examples/CMakeFiles/gender_googlenet.dir/build

examples/CMakeFiles/gender_googlenet.dir/clean:
	cd /app/build/examples && $(CMAKE_COMMAND) -P CMakeFiles/gender_googlenet.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/gender_googlenet.dir/clean

examples/CMakeFiles/gender_googlenet.dir/depend:
	cd /app/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /app /app/examples /app/build /app/build/examples /app/build/examples/CMakeFiles/gender_googlenet.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/CMakeFiles/gender_googlenet.dir/depend

