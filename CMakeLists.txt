# The target of the FACE library is exported
# as FACE::FACE to a package configuration file for this library
#
# usage:
#     find_package(FACE)/add_subdirectory(...)
#     ...
#     target_link_library(<target> FACE::FACE)
#
# the config file is generatet in the build and install directories
#
# to build the documentation build the target doc (ford is needed)
#
# to build the tests enable the option BUILD_TESTING (FACE_BUILD_TESTING)
# if this is the main project (a subproject)
# afterwards they can be run with ctest

cmake_minimum_required(VERSION 3.14...3.15)
project(FACE VERSION 1.1.1 LANGUAGES Fortran)

# set export variables needed in subdirectories
set(TARGETS_EXPORT_NAME "${PROJECT_NAME}-targets")
set(NAMESPACE "${PROJECT_NAME}::")

# set variables used for compile definitions of targets after support check
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

# generate the library and install instructions
add_subdirectory(src/lib)

# documentation
add_subdirectory(doc EXCLUDE_FROM_ALL)

# testing
if(${PROJECT_SOURCE_DIR} STREQUAL ${CMAKE_SOURCE_DIR})
    set(main_project TRUE)
    option(BUILD_TESTING "Build the testing tree." OFF)
else()
    set(main_project FALSE)

    # if this is not the main project but BUILD_TESTIG is set to TRUE
    # the tests for this project can be enabled by also setting
    # BUILD_TESTING_${PROJECT_NAME} to TRUE
    include(CMakeDependentOption)
    cmake_dependent_option(BUILD_TESTING_${PROJECT_NAME}
        "Build the testing tree for project ${PROJECT_NAME}." OFF
        "BUILD_TESTING;NOT main_project" OFF
    )
endif()

if((main_project OR BUILD_TESTING_${PROJECT_NAME}) AND BUILD_TESTING)
    enable_testing()
    add_subdirectory(src/tests)
endif()

# generate package config files
include(GNUInstallDirs)
set(project_config "${PROJECT_NAME}-config.cmake")
set(project_config_version "${PROJECT_NAME}-config-version.cmake")
set(cmake_files_dir "${CMAKE_CURRENT_BINARY_DIR}/CMakeFiles")
set(default_config_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")
set(config_build_dir "${CMAKE_CURRENT_BINARY_DIR}/${default_config_install_dir}")
set(${PROJECT_NAME}_INSTALL_CMAKEDIR ${default_config_install_dir} CACHE PATH "Path into which the cmake files for project ${PROJECT_NAME} will be installed.")

# export targets for install
install(EXPORT ${TARGETS_EXPORT_NAME}
    NAMESPACE
        ${NAMESPACE}
    DESTINATION
        ${${PROJECT_NAME}_INSTALL_CMAKEDIR}
    COMPONENT
        ${PROJECT_NAME}_Development
)

# export targets into build
export(EXPORT ${TARGETS_EXPORT_NAME}
    NAMESPACE
        ${NAMESPACE}
    FILE
        "${config_build_dir}/${TARGETS_EXPORT_NAME}.cmake"
)

# create package config
# Variables needed by PackageConfig.cmake.in: PROJECT_NAME, TARGETS_EXPORT_NAME

include(CMakePackageConfigHelpers)
configure_package_config_file(cmake/PackageConfig.cmake.in "${cmake_files_dir}/${project_config}"
    INSTALL_DESTINATION ${${PROJECT_NAME}_INSTALL_CMAKEDIR}
)

configure_package_config_file(cmake/PackageConfig.cmake.in "${config_build_dir}/${project_config}"
    INSTALL_DESTINATION ${config_build_dir}
    INSTALL_PREFIX ${CMAKE_CURRENT_BINARY_DIR}
)

write_basic_package_version_file(
    ${project_config_version}
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
)

install(
    FILES
        "${cmake_files_dir}/${project_config}"
        "${CMAKE_CURRENT_BINARY_DIR}/${project_config_version}"
    DESTINATION
        ${${PROJECT_NAME}_INSTALL_CMAKEDIR}
    COMPONENT
        ${PROJECT_NAME}_Development
)
