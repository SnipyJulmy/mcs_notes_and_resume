# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

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
CMAKE_COMMAND = /home/snipy/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/181.4445.84/bin/cmake/bin/cmake

# The command to remove a file.
RM = /home/snipy/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/181.4445.84/bin/cmake/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/queue.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/queue.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/queue.dir/flags.make

CMakeFiles/queue.dir/array_stack.c.o: CMakeFiles/queue.dir/flags.make
CMakeFiles/queue.dir/array_stack.c.o: ../array_stack.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/queue.dir/array_stack.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/queue.dir/array_stack.c.o   -c /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/array_stack.c

CMakeFiles/queue.dir/array_stack.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/queue.dir/array_stack.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/array_stack.c > CMakeFiles/queue.dir/array_stack.c.i

CMakeFiles/queue.dir/array_stack.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/queue.dir/array_stack.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/array_stack.c -o CMakeFiles/queue.dir/array_stack.c.s

CMakeFiles/queue.dir/array_stack.c.o.requires:

.PHONY : CMakeFiles/queue.dir/array_stack.c.o.requires

CMakeFiles/queue.dir/array_stack.c.o.provides: CMakeFiles/queue.dir/array_stack.c.o.requires
	$(MAKE) -f CMakeFiles/queue.dir/build.make CMakeFiles/queue.dir/array_stack.c.o.provides.build
.PHONY : CMakeFiles/queue.dir/array_stack.c.o.provides

CMakeFiles/queue.dir/array_stack.c.o.provides.build: CMakeFiles/queue.dir/array_stack.c.o


CMakeFiles/queue.dir/array_stack_main.c.o: CMakeFiles/queue.dir/flags.make
CMakeFiles/queue.dir/array_stack_main.c.o: ../array_stack_main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/queue.dir/array_stack_main.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/queue.dir/array_stack_main.c.o   -c /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/array_stack_main.c

CMakeFiles/queue.dir/array_stack_main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/queue.dir/array_stack_main.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/array_stack_main.c > CMakeFiles/queue.dir/array_stack_main.c.i

CMakeFiles/queue.dir/array_stack_main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/queue.dir/array_stack_main.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/array_stack_main.c -o CMakeFiles/queue.dir/array_stack_main.c.s

CMakeFiles/queue.dir/array_stack_main.c.o.requires:

.PHONY : CMakeFiles/queue.dir/array_stack_main.c.o.requires

CMakeFiles/queue.dir/array_stack_main.c.o.provides: CMakeFiles/queue.dir/array_stack_main.c.o.requires
	$(MAKE) -f CMakeFiles/queue.dir/build.make CMakeFiles/queue.dir/array_stack_main.c.o.provides.build
.PHONY : CMakeFiles/queue.dir/array_stack_main.c.o.provides

CMakeFiles/queue.dir/array_stack_main.c.o.provides.build: CMakeFiles/queue.dir/array_stack_main.c.o


# Object files for target queue
queue_OBJECTS = \
"CMakeFiles/queue.dir/array_stack.c.o" \
"CMakeFiles/queue.dir/array_stack_main.c.o"

# External object files for target queue
queue_EXTERNAL_OBJECTS =

queue: CMakeFiles/queue.dir/array_stack.c.o
queue: CMakeFiles/queue.dir/array_stack_main.c.o
queue: CMakeFiles/queue.dir/build.make
queue: CMakeFiles/queue.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable queue"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/queue.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/queue.dir/build: queue

.PHONY : CMakeFiles/queue.dir/build

CMakeFiles/queue.dir/requires: CMakeFiles/queue.dir/array_stack.c.o.requires
CMakeFiles/queue.dir/requires: CMakeFiles/queue.dir/array_stack_main.c.o.requires

.PHONY : CMakeFiles/queue.dir/requires

CMakeFiles/queue.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/queue.dir/cmake_clean.cmake
.PHONY : CMakeFiles/queue.dir/clean

CMakeFiles/queue.dir/depend:
	cd /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug/CMakeFiles/queue.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/queue.dir/depend

