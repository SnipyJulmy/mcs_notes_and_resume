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
CMAKE_SOURCE_DIR = /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s05/exercices/sup

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s05/exercices/sup/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/sup.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/sup.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/sup.dir/flags.make

CMakeFiles/sup.dir/main.c.o: CMakeFiles/sup.dir/flags.make
CMakeFiles/sup.dir/main.c.o: ../main.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s05/exercices/sup/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/sup.dir/main.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/sup.dir/main.c.o   -c /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s05/exercices/sup/main.c

CMakeFiles/sup.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/sup.dir/main.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s05/exercices/sup/main.c > CMakeFiles/sup.dir/main.c.i

CMakeFiles/sup.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/sup.dir/main.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s05/exercices/sup/main.c -o CMakeFiles/sup.dir/main.c.s

CMakeFiles/sup.dir/main.c.o.requires:

.PHONY : CMakeFiles/sup.dir/main.c.o.requires

CMakeFiles/sup.dir/main.c.o.provides: CMakeFiles/sup.dir/main.c.o.requires
	$(MAKE) -f CMakeFiles/sup.dir/build.make CMakeFiles/sup.dir/main.c.o.provides.build
.PHONY : CMakeFiles/sup.dir/main.c.o.provides

CMakeFiles/sup.dir/main.c.o.provides.build: CMakeFiles/sup.dir/main.c.o


# Object files for target sup
sup_OBJECTS = \
"CMakeFiles/sup.dir/main.c.o"

# External object files for target sup
sup_EXTERNAL_OBJECTS =

sup: CMakeFiles/sup.dir/main.c.o
sup: CMakeFiles/sup.dir/build.make
sup: CMakeFiles/sup.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s05/exercices/sup/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable sup"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/sup.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/sup.dir/build: sup

.PHONY : CMakeFiles/sup.dir/build

CMakeFiles/sup.dir/requires: CMakeFiles/sup.dir/main.c.o.requires

.PHONY : CMakeFiles/sup.dir/requires

CMakeFiles/sup.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/sup.dir/cmake_clean.cmake
.PHONY : CMakeFiles/sup.dir/clean

CMakeFiles/sup.dir/depend:
	cd /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s05/exercices/sup/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s05/exercices/sup /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s05/exercices/sup /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s05/exercices/sup/cmake-build-debug /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s05/exercices/sup/cmake-build-debug /home/snipy/Master/mcs-git/sys-oriented-prog/exercices/s05/exercices/sup/cmake-build-debug/CMakeFiles/sup.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/sup.dir/depend
