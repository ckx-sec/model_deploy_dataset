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
include examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/compiler_depend.make

# Include the progress variables for this target.
include examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/progress.make

# Include the compile flags for this target's objects.
include examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/flags.make

examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.o: examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/flags.make
examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.o: /app/examples/onnxruntime/fsanet_headpose.cpp
examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.o: examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/app/build_clang_debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.o"
	cd /app/build_clang_debug/examples/onnxruntime && /usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.o -MF CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.o.d -o CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.o -c /app/examples/onnxruntime/fsanet_headpose.cpp

examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.i"
	cd /app/build_clang_debug/examples/onnxruntime && /usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /app/examples/onnxruntime/fsanet_headpose.cpp > CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.i

examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.s"
	cd /app/build_clang_debug/examples/onnxruntime && /usr/bin/clang++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /app/examples/onnxruntime/fsanet_headpose.cpp -o CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.s

# Object files for target fsanet_headpose_onnxruntime
fsanet_headpose_onnxruntime_OBJECTS = \
"CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.o"

# External object files for target fsanet_headpose_onnxruntime
fsanet_headpose_onnxruntime_EXTERNAL_OBJECTS =

bin/fsanet_headpose_onnxruntime: examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/fsanet_headpose.cpp.o
bin/fsanet_headpose_onnxruntime: examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/build.make
bin/fsanet_headpose_onnxruntime: src/libmodel_deploy_dataset_lib.so
bin/fsanet_headpose_onnxruntime: /usr/lib/aarch64-linux-gnu/libopencv_highgui.so.4.2.0
bin/fsanet_headpose_onnxruntime: /app/third_party/onnxruntime/lib/libonnxruntime.so
bin/fsanet_headpose_onnxruntime: /usr/lib/aarch64-linux-gnu/libopencv_videoio.so.4.2.0
bin/fsanet_headpose_onnxruntime: /usr/lib/aarch64-linux-gnu/libopencv_imgcodecs.so.4.2.0
bin/fsanet_headpose_onnxruntime: /usr/lib/aarch64-linux-gnu/libopencv_imgproc.so.4.2.0
bin/fsanet_headpose_onnxruntime: /usr/lib/aarch64-linux-gnu/libopencv_core.so.4.2.0
bin/fsanet_headpose_onnxruntime: examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/app/build_clang_debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../../bin/fsanet_headpose_onnxruntime"
	cd /app/build_clang_debug/examples/onnxruntime && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/fsanet_headpose_onnxruntime.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/build: bin/fsanet_headpose_onnxruntime
.PHONY : examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/build

examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/clean:
	cd /app/build_clang_debug/examples/onnxruntime && $(CMAKE_COMMAND) -P CMakeFiles/fsanet_headpose_onnxruntime.dir/cmake_clean.cmake
.PHONY : examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/clean

examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/depend:
	cd /app/build_clang_debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /app /app/examples/onnxruntime /app/build_clang_debug /app/build_clang_debug/examples/onnxruntime /app/build_clang_debug/examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : examples/onnxruntime/CMakeFiles/fsanet_headpose_onnxruntime.dir/depend

