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
include CMakeFiles/exercices.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/exercices.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/exercices.dir/flags.make

CMakeFiles/exercices.dir/array_stack.c.o: CMakeFiles/exercices.dir/flags.make
CMakeFiles/exercices.dir/array_stack.c.o: ../array_stack.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/exercices.dir/array_stack.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/exercices.dir/array_stack.c.o   -c /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/array_stack.c

CMakeFiles/exercices.dir/array_stack.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/exercices.dir/array_stack.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/array_stack.c > CMakeFiles/exercices.dir/array_stack.c.i

CMakeFiles/exercices.dir/array_stack.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/exercices.dir/array_stack.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/array_stack.c -o CMakeFiles/exercices.dir/array_stack.c.s

CMakeFiles/exercices.dir/array_stack.c.o.requires:

.PHONY : CMakeFiles/exercices.dir/array_stack.c.o.requires

CMakeFiles/exercices.dir/array_stack.c.o.provides: CMakeFiles/exercices.dir/array_stack.c.o.requires
	$(MAKE) -f CMakeFiles/exercices.dir/build.make CMakeFiles/exercices.dir/array_stack.c.o.provides.build
.PHONY : CMakeFiles/exercices.dir/array_stack.c.o.provides

CMakeFiles/exercices.dir/array_stack.c.o.provides.build: CMakeFiles/exercices.dir/array_stack.c.o


CMakeFiles/exercices.dir/array_stack_main.c.o: CMakeFiles/exercices.dir/flags.make
CMakeFiles/exercices.dir/array_stack_main.c.o: ../array_stack_main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/exercices.dir/array_stack_main.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/exercices.dir/array_stack_main.c.o   -c /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/array_stack_main.c

CMakeFiles/exercices.dir/array_stack_main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/exercices.dir/array_stack_main.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/array_stack_main.c > CMakeFiles/exercices.dir/array_stack_main.c.i

CMakeFiles/exercices.dir/array_stack_main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/exercices.dir/array_stack_main.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/array_stack_main.c -o CMakeFiles/exercices.dir/array_stack_main.c.s

CMakeFiles/exercices.dir/array_stack_main.c.o.requires:

.PHONY : CMakeFiles/exercices.dir/array_stack_main.c.o.requires

CMakeFiles/exercices.dir/array_stack_main.c.o.provides: CMakeFiles/exercices.dir/array_stack_main.c.o.requires
	$(MAKE) -f CMakeFiles/exercices.dir/build.make CMakeFiles/exercices.dir/array_stack_main.c.o.provides.build
.PHONY : CMakeFiles/exercices.dir/array_stack_main.c.o.provides

CMakeFiles/exercices.dir/array_stack_main.c.o.provides.build: CMakeFiles/exercices.dir/array_stack_main.c.o


CMakeFiles/exercices.dir/linked_list_stack.c.o: CMakeFiles/exercices.dir/flags.make
CMakeFiles/exercices.dir/linked_list_stack.c.o: ../linked_list_stack.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/exercices.dir/linked_list_stack.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/exercices.dir/linked_list_stack.c.o   -c /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/linked_list_stack.c

CMakeFiles/exercices.dir/linked_list_stack.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/exercices.dir/linked_list_stack.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/linked_list_stack.c > CMakeFiles/exercices.dir/linked_list_stack.c.i

CMakeFiles/exercices.dir/linked_list_stack.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/exercices.dir/linked_list_stack.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/linked_list_stack.c -o CMakeFiles/exercices.dir/linked_list_stack.c.s

CMakeFiles/exercices.dir/linked_list_stack.c.o.requires:

.PHONY : CMakeFiles/exercices.dir/linked_list_stack.c.o.requires

CMakeFiles/exercices.dir/linked_list_stack.c.o.provides: CMakeFiles/exercices.dir/linked_list_stack.c.o.requires
	$(MAKE) -f CMakeFiles/exercices.dir/build.make CMakeFiles/exercices.dir/linked_list_stack.c.o.provides.build
.PHONY : CMakeFiles/exercices.dir/linked_list_stack.c.o.provides

CMakeFiles/exercices.dir/linked_list_stack.c.o.provides.build: CMakeFiles/exercices.dir/linked_list_stack.c.o


CMakeFiles/exercices.dir/minimal_tree.c.o: CMakeFiles/exercices.dir/flags.make
CMakeFiles/exercices.dir/minimal_tree.c.o: ../minimal_tree.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object CMakeFiles/exercices.dir/minimal_tree.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/exercices.dir/minimal_tree.c.o   -c /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/minimal_tree.c

CMakeFiles/exercices.dir/minimal_tree.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/exercices.dir/minimal_tree.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/minimal_tree.c > CMakeFiles/exercices.dir/minimal_tree.c.i

CMakeFiles/exercices.dir/minimal_tree.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/exercices.dir/minimal_tree.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/minimal_tree.c -o CMakeFiles/exercices.dir/minimal_tree.c.s

CMakeFiles/exercices.dir/minimal_tree.c.o.requires:

.PHONY : CMakeFiles/exercices.dir/minimal_tree.c.o.requires

CMakeFiles/exercices.dir/minimal_tree.c.o.provides: CMakeFiles/exercices.dir/minimal_tree.c.o.requires
	$(MAKE) -f CMakeFiles/exercices.dir/build.make CMakeFiles/exercices.dir/minimal_tree.c.o.provides.build
.PHONY : CMakeFiles/exercices.dir/minimal_tree.c.o.provides

CMakeFiles/exercices.dir/minimal_tree.c.o.provides.build: CMakeFiles/exercices.dir/minimal_tree.c.o


# Object files for target exercices
exercices_OBJECTS = \
"CMakeFiles/exercices.dir/array_stack.c.o" \
"CMakeFiles/exercices.dir/array_stack_main.c.o" \
"CMakeFiles/exercices.dir/linked_list_stack.c.o" \
"CMakeFiles/exercices.dir/minimal_tree.c.o"

# External object files for target exercices
exercices_EXTERNAL_OBJECTS =

exercices: CMakeFiles/exercices.dir/array_stack.c.o
exercices: CMakeFiles/exercices.dir/array_stack_main.c.o
exercices: CMakeFiles/exercices.dir/linked_list_stack.c.o
exercices: CMakeFiles/exercices.dir/minimal_tree.c.o
exercices: CMakeFiles/exercices.dir/build.make
exercices: CMakeFiles/exercices.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking C executable exercices"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/exercices.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/exercices.dir/build: exercices

.PHONY : CMakeFiles/exercices.dir/build

CMakeFiles/exercices.dir/requires: CMakeFiles/exercices.dir/array_stack.c.o.requires
CMakeFiles/exercices.dir/requires: CMakeFiles/exercices.dir/array_stack_main.c.o.requires
CMakeFiles/exercices.dir/requires: CMakeFiles/exercices.dir/linked_list_stack.c.o.requires
CMakeFiles/exercices.dir/requires: CMakeFiles/exercices.dir/minimal_tree.c.o.requires

.PHONY : CMakeFiles/exercices.dir/requires

CMakeFiles/exercices.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/exercices.dir/cmake_clean.cmake
.PHONY : CMakeFiles/exercices.dir/clean

CMakeFiles/exercices.dir/depend:
	cd /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s11/exercices/cmake-build-debug/CMakeFiles/exercices.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/exercices.dir/depend
