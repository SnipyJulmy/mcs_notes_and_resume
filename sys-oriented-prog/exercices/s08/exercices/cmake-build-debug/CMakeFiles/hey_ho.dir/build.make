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
CMAKE_SOURCE_DIR = /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s08/exercices

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s08/exercices/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/hey_ho.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/hey_ho.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/hey_ho.dir/flags.make

CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o: CMakeFiles/hey_ho.dir/flags.make
CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o: ../ex2/hey_ho.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s08/exercices/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o   -c /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s08/exercices/ex2/hey_ho.c

CMakeFiles/hey_ho.dir/ex2/hey_ho.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/hey_ho.dir/ex2/hey_ho.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s08/exercices/ex2/hey_ho.c > CMakeFiles/hey_ho.dir/ex2/hey_ho.c.i

CMakeFiles/hey_ho.dir/ex2/hey_ho.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/hey_ho.dir/ex2/hey_ho.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s08/exercices/ex2/hey_ho.c -o CMakeFiles/hey_ho.dir/ex2/hey_ho.c.s

CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o.requires:

.PHONY : CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o.requires

CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o.provides: CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o.requires
	$(MAKE) -f CMakeFiles/hey_ho.dir/build.make CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o.provides.build
.PHONY : CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o.provides

CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o.provides.build: CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o


# Object files for target hey_ho
hey_ho_OBJECTS = \
"CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o"

# External object files for target hey_ho
hey_ho_EXTERNAL_OBJECTS =

hey_ho: CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o
hey_ho: CMakeFiles/hey_ho.dir/build.make
hey_ho: CMakeFiles/hey_ho.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s08/exercices/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable hey_ho"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/hey_ho.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/hey_ho.dir/build: hey_ho

.PHONY : CMakeFiles/hey_ho.dir/build

CMakeFiles/hey_ho.dir/requires: CMakeFiles/hey_ho.dir/ex2/hey_ho.c.o.requires

.PHONY : CMakeFiles/hey_ho.dir/requires

CMakeFiles/hey_ho.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/hey_ho.dir/cmake_clean.cmake
.PHONY : CMakeFiles/hey_ho.dir/clean

CMakeFiles/hey_ho.dir/depend:
	cd /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s08/exercices/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s08/exercices /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s08/exercices /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s08/exercices/cmake-build-debug /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s08/exercices/cmake-build-debug /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s08/exercices/cmake-build-debug/CMakeFiles/hey_ho.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/hey_ho.dir/depend

