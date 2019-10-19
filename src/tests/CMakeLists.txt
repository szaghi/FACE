include(GNUInstallDirs)

SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/tests/${CMAKE_INSTALL_BINDIR}")

function(add_face_test test_src libraries)
    get_filename_component(test_name ${test_src} NAME_WE)

    add_executable(${test_name} ${test_src})
    foreach(lib IN LISTS libraries)
        target_link_libraries(${test_name} ${lib})
    endforeach()
    add_test(NAME ${test_name} COMMAND ${test_name})
endfunction()

foreach(face_test
    face_test_basic.f90
    face_test_colors.f90
    face_test_styles.f90
    face_test_ucs4.F90
)
    add_face_test(${face_test} FACE)
endforeach()

target_compile_definitions(face_test_ucs4
    PRIVATE
        ${ucs4_supported}
)
