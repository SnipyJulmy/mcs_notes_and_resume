# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.9

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
CMAKE_COMMAND = /home/snipy/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/173.4548.31/bin/cmake/bin/cmake

# The command to remove a file.
RM = /home/snipy/.local/share/JetBrains/Toolbox/apps/CLion/ch-0/173.4548.31/bin/cmake/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/snipy/Master/mcs-git/os/exercices/s04/exercises

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/snipy/Master/mcs-git/os/exercices/s04/exercises/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/ex4_a.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/ex4_a.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/ex4_a.dir/flags.make

CMakeFiles/ex4_a.dir/ex4_a.c.o: CMakeFiles/ex4_a.dir/flags.make
CMakeFiles/ex4_a.dir/ex4_a.c.o: ../ex4_a.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/snipy/Master/mcs-git/os/exercices/s04/exercises/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/ex4_a.dir/ex4_a.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/ex4_a.dir/ex4_a.c.o   -c /home/snipy/Master/mcs-git/os/exercices/s04/exercises/ex4_a.c

CMakeFiles/ex4_a.dir/ex4_a.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/ex4_a.dir/ex4_a.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/snipy/Master/mcs-git/os/exercices/s04/exercises/ex4_a.c > CMakeFiles/ex4_a.dir/ex4_a.c.i

CMakeFiles/ex4_a.dir/ex4_a.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/ex4_a.dir/ex4_a.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/snipy/Master/mcs-git/os/exercices/s04/exercises/ex4_a.c -o CMakeFiles/ex4_a.dir/ex4_a.c.s

CMakeFiles/ex4_a.dir/ex4_a.c.o.requires:

.PHONY : CMakeFiles/ex4_a.dir/ex4_a.c.o.requires

CMakeFiles/ex4_a.dir/ex4_a.c.o.provides: CMakeFiles/ex4_a.dir/ex4_a.c.o.requires
	$(MAKE) -f CMakeFiles/ex4_a.dir/build.make CMakeFiles/ex4_a.dir/ex4_a.c.o.provides.build
.PHONY : CMakeFiles/ex4_a.dir/ex4_a.c.o.provides

CMakeFiles/ex4_a.dir/ex4_a.c.o.provides.build: CMakeFiles/ex4_a.dir/ex4_a.c.o


# Object files for target ex4_a
ex4_a_OBJECTS = \
"CMakeFiles/ex4_a.dir/ex4_a.c.o"

# External object files for target ex4_a
ex4_a_EXTERNAL_OBJECTS =

ex4_a: CMakeFiles/ex4_a.dir/ex4_a.c.o
ex4_a: CMakeFiles/ex4_a.dir/build.make
ex4_a: CMakeFiles/ex4_a.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/snipy/Master/mcs-git/os/exercices/s04/exercises/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable ex4_a"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ex4_a.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/ex4_a.dir/build: ex4_a

.PHONY : CMakeFiles/ex4_a.dir/build

CMakeFiles/ex4_a.dir/requires: CMakeFiles/ex4_a.dir/ex4_a.c.o.requires

.PHONY : CMakeFiles/ex4_a.dir/requires

CMakeFiles/ex4_a.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/ex4_a.dir/cmake_clean.cmake
.PHONY : CMakeFiles/ex4_a.dir/clean

CMakeFiles/ex4_a.dir/depend:
	cd /home/snipy/Master/mcs-git/os/exercices/s04/exercises/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/snipy/Master/mcs-git/os/exercices/s04/exercises /home/snipy/Master/mcs-git/os/exercices/s04/exercises /home/snipy/Master/mcs-git/os/exercices/s04/exercises/cmake-build-debug /home/snipy/Master/mcs-git/os/exercices/s04/exercises/cmake-build-debug /home/snipy/Master/mcs-git/os/exercices/s04/exercises/cmake-build-debug/CMakeFiles/ex4_a.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/ex4_a.dir/depend

