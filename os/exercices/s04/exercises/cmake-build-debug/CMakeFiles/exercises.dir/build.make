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
include CMakeFiles/exercises.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/exercises.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/exercises.dir/flags.make

CMakeFiles/exercises.dir/ex4_a.c.o: CMakeFiles/exercises.dir/flags.make
CMakeFiles/exercises.dir/ex4_a.c.o: ../ex4_a.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/snipy/Master/mcs-git/os/exercices/s04/exercises/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/exercises.dir/ex4_a.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/exercises.dir/ex4_a.c.o   -c /home/snipy/Master/mcs-git/os/exercices/s04/exercises/ex4_a.c

CMakeFiles/exercises.dir/ex4_a.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/exercises.dir/ex4_a.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/snipy/Master/mcs-git/os/exercices/s04/exercises/ex4_a.c > CMakeFiles/exercises.dir/ex4_a.c.i

CMakeFiles/exercises.dir/ex4_a.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/exercises.dir/ex4_a.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/snipy/Master/mcs-git/os/exercices/s04/exercises/ex4_a.c -o CMakeFiles/exercises.dir/ex4_a.c.s

CMakeFiles/exercises.dir/ex4_a.c.o.requires:

.PHONY : CMakeFiles/exercises.dir/ex4_a.c.o.requires

CMakeFiles/exercises.dir/ex4_a.c.o.provides: CMakeFiles/exercises.dir/ex4_a.c.o.requires
	$(MAKE) -f CMakeFiles/exercises.dir/build.make CMakeFiles/exercises.dir/ex4_a.c.o.provides.build
.PHONY : CMakeFiles/exercises.dir/ex4_a.c.o.provides

CMakeFiles/exercises.dir/ex4_a.c.o.provides.build: CMakeFiles/exercises.dir/ex4_a.c.o


# Object files for target exercises
exercises_OBJECTS = \
"CMakeFiles/exercises.dir/ex4_a.c.o"

# External object files for target exercises
exercises_EXTERNAL_OBJECTS =

exercises: CMakeFiles/exercises.dir/ex4_a.c.o
exercises: CMakeFiles/exercises.dir/build.make
exercises: CMakeFiles/exercises.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/snipy/Master/mcs-git/os/exercices/s04/exercises/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable exercises"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/exercises.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/exercises.dir/build: exercises

.PHONY : CMakeFiles/exercises.dir/build

CMakeFiles/exercises.dir/requires: CMakeFiles/exercises.dir/ex4_a.c.o.requires

.PHONY : CMakeFiles/exercises.dir/requires

CMakeFiles/exercises.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/exercises.dir/cmake_clean.cmake
.PHONY : CMakeFiles/exercises.dir/clean

CMakeFiles/exercises.dir/depend:
	cd /home/snipy/Master/mcs-git/os/exercices/s04/exercises/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/snipy/Master/mcs-git/os/exercices/s04/exercises /home/snipy/Master/mcs-git/os/exercices/s04/exercises /home/snipy/Master/mcs-git/os/exercices/s04/exercises/cmake-build-debug /home/snipy/Master/mcs-git/os/exercices/s04/exercises/cmake-build-debug /home/snipy/Master/mcs-git/os/exercices/s04/exercises/cmake-build-debug/CMakeFiles/exercises.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/exercises.dir/depend
