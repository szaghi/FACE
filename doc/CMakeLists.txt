find_program(ford_exe NAMES ford)

if(ford_exe)
    set(DOC_DIR "${PROJECT_BINARY_DIR}/doc")
    set(ford_config "main_page.md")

    add_custom_target(doc
        COMMAND ${ford_exe} -o ${DOC_DIR} ${ford_config}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    )
endif()