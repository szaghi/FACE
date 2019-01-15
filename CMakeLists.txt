# The target of the library FACE is exported
# as FACE::FACE to a package config file for FACE
#
# usage find_package(FACE)
# ...
# target_link_library(<target> FACE)
#
# the config file is generatet in the build and install directories

#################################################################
# HEADER
#################################################################
cmake_minimum_required(VERSION 3.10...3.13)
project(FACE VERSION 1.1.1 LANGUAGES Fortran)

#################################################################
# seach path for additional cmake modules
#################################################################
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake/Modules)

#################################################################
# set export variables needed for building
#################################################################

set(TARGETS_EXPORT_NAME "${PROJECT_NAME}Targets")
set(NAMESPACE "${PROJECT_NAME}::")

#################################################################
# set variables used for compile definitions of targets
#################################################################

include(CheckFortranSourceRuns)

check_fortran_source_runs(
    "program ascii_support;
         integer, parameter :: ascii = selected_char_kind('ascii');
         if(ascii < 0) stop 1;
     end program ascii_support"
    ASCII_SUPPORTED
    SRC_EXT f90)
if(ASCII_SUPPORTED)
    set(ascii_supported "ASCII_SUPPORTED")
endif()

check_fortran_source_runs(
    "program ascii_neq_default;
         integer, parameter :: ascii = selected_char_kind('ascii');
         integer, parameter :: default = selected_char_kind('default');
         if(ascii == default) stop 1;
     end program ascii_neq_default"
    ASCII_NEQ_DEFAULT
    SRC_EXT f90
)
if(ASCII_NEQ_DEFAULT)
    set(ascii_neq_default "ASCII_NEQ_DEFAULT")
endif()

check_fortran_source_runs(
    "program ucs4_support;
         integer, parameter :: ucs4 = selected_char_kind('iso_10646');
         if(ucs4 < 0) stop 1;
     end program ucs4_support"
    UCS4_SUPPORTED
    SRC_EXT f90)
if(UCS4_SUPPORTED)
    set(ucs4_supported "UCS4_SUPPORTED")
endif()

#################################################################
# generate the library and install instructions
#################################################################

add_subdirectory(src/lib)

#################################################################
# ENABLE TESTING
#################################################################

if(${PROJECT_SOURCE_DIR} STREQUAL ${CMAKE_SOURCE_DIR})
    set(main_project TRUE)
else()
    set(main_project FALSE)
endif()

include(CMakeDependentOption)
cmake_dependent_option(BUILD_TESTING_${PROJECT_NAME}
     "Build the testing tree for project ${PROJECT_NAME}." OFF
     "BUILD_TESTING;NOT main_project" OFF
)

if(main_project OR BUILD_TESTING_${PROJECT_NAME})
    enable_testing()
    add_subdirectory(src/tests)
endif()

#################################################################
# generate package config files
#################################################################

include(GNUInstallDirs)
set(project_config "${PROJECT_NAME}Config.cmake")
set(cmake_files_dir "${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles")
set(config_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")
set(config_build_dir "${CMAKE_CURRENT_BINARY_DIR}/${config_install_dir}")

# export targets for install
install(EXPORT ${TARGETS_EXPORT_NAME}
    NAMESPACE
        ${NAMESPACE}
    DESTINATION
        ${config_install_dir}
    COMPONENT Development
)

# export targets into build
export(EXPORT ${TARGETS_EXPORT_NAME}
    NAMESPACE
        ${NAMESPACE}
    FILE
        ${config_build_dir}/${TARGETS_EXPORT_NAME}.cmake
)

#create package config
include(CMakePackageConfigHelpers)
configure_package_config_file(cmake/PackageConfig.cmake.in ${cmake_files_dir}/${project_config}
    INSTALL_DESTINATION ${config_install_dir}
)
install(FILES ${cmake_files_dir}/${project_config}
    DESTINATION ${config_install_dir}
)

configure_package_config_file(cmake/PackageConfig.cmake.in ${config_build_dir}/${project_config}
    INSTALL_DESTINATION ${config_build_dir}
    INSTALL_PREFIX ${CMAKE_CURRENT_BINARY_DIR}
)
