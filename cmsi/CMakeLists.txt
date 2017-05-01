cmake_minimum_required(VERSION 3.6)
project(cmsi)

if(NOT TARGET cmst)
  add_subdirectory(../cmst ${CMAKE_BINARY_DIR}/cms/cmst)
endif()

add_custom_target(cmsi DEPENDS cmst)

get_target_property(cmst_modulePaths cmst CMAKE_MODULE_PATH)
set_property(TARGET cmsi PROPERTY CMAKE_MODULE_PATH
  ${CMAKE_CURRENT_LIST_DIR}
  ${cmst_modulePaths}
)

get_target_property(cmsi_modulePaths cmsi CMAKE_MODULE_PATH)

add_test(
  NAME cmsi_import.t
  COMMAND
    ${CMAKE_COMMAND}
      "-DCMAKE_MODULE_PATH=${cmsi_modulePaths}"
      -P ${CMAKE_CURRENT_LIST_DIR}/cmsi_import.t.cmake
)
