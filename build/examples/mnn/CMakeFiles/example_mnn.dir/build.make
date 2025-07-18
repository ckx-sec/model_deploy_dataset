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
include examples/mnn/CMakeFiles/example_mnn.dir/depend.make

# Include the progress variables for this target.
include examples/mnn/CMakeFiles/example_mnn.dir/progress.make

# Include the compile flags for this target's objects.
include examples/mnn/CMakeFiles/example_mnn.dir/flags.make

examples/mnn/CMakeFiles/example_mnn.dir/example_mnn.cpp.o: examples/mnn/CMakeFiles/example_mnn.dir/flags.make
examples/mnn/CMakeFiles/example_mnn.dir/example_mnn.cpp.o: ../examples/mnn/example_mnn.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/mnn/CMakeFiles/example_mnn.dir/example_mnn.cpp.o"
	cd /app/build/examples/mnn && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/example_mnn.dir/example_mnn.cpp.o -c /app/examples/mnn/example_mnn.cpp

examples/mnn/CMakeFiles/example_mnn.dir/example_mnn.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/example_mnn.dir/example_mnn.cpp.i"
	cd /app/build/examples/mnn && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /app/examples/mnn/example_mnn.cpp > CMakeFiles/example_mnn.dir/example_mnn.cpp.i

examples/mnn/CMakeFiles/example_mnn.dir/example_mnn.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/example_mnn.dir/example_mnn.cpp.s"
	cd /app/build/examples/mnn && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /app/examples/mnn/example_mnn.cpp -o CMakeFiles/example_mnn.dir/example_mnn.cpp.s

# Object files for target example_mnn
example_mnn_OBJECTS = \
"CMakeFiles/example_mnn.dir/example_mnn.cpp.o"

# External object files for target example_mnn
example_mnn_EXTERNAL_OBJECTS =

bin/example_mnn: examples/mnn/CMakeFiles/example_mnn.dir/example_mnn.cpp.o
bin/example_mnn: examples/mnn/CMakeFiles/example_mnn.dir/build.make
bin/example_mnn: src/libmodel_deploy_dataset_lib.so
bin/example_mnn: /usr/lib/aarch64-linux-gnu/libopencv_highgui.so.4.2.0
bin/example_mnn: ../third_party/mnn/lib/libMNN.so
bin/example_mnn: /usr/lib/aarch64-linux-gnu/libopencv_videoio.so.4.2.0
bin/example_mnn: /usr/lib/aarch64-linux-gnu/libopencv_imgcodecs.so.4.2.0
bin/example_mnn: /usr/lib/aarch64-linux-gnu/libopencv_imgproc.so.4.2.0
bin/example_mnn: /usr/lib/aarch64-linux-gnu/libopencv_core.so.4.2.0
bin/example_mnn: examples/mnn/CMakeFiles/example_mnn.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/app/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../../bin/example_mnn"
	cd /app/build/examples/mnn && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/example_mnn.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/mnn/CMakeFiles/example_mnn.dir/build: bin/example_mnn

.PHONY : examples/mnn/CMakeFiles/example_mnn.dir/build

examples/mnn/CMakeFiles/example_mnn.dir/clean:
	cd /app/build/examples/mnn && $(CMAKE_COMMAND) -P CMakeFiles/example_mnn.dir/cmake_clean.cmake
.PHONY : examples/mnn/CMakeFiles/example_mnn.dir/clean

examples/mnn/CMakeFiles/example_mnn.dir/depend:
	cd /app/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /app /app/examples/mnn /app/build /app/build/examples/mnn /app/build/examples/mnn/CMakeFiles/example_mnn.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/mnn/CMakeFiles/example_mnn.dir/depend

