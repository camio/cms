cmake_minimum_required(VERSION 3.6)
project(cms)

# Note that we're using poor man's import in this package group here as a means
# to bootstrap cmsi.

if(NOT TARGET cmsfm)
  add_subdirectory(cmsfm ${CMAKE_BINARY_DIR}/cms/cmsfm)
endif()

if(NOT TARGET cmsi)
  add_subdirectory(cmsi ${CMAKE_BINARY_DIR}/cms/cmsi)
endif()

if(NOT TARGET cmst)
  add_subdirectory(cmst ${CMAKE_BINARY_DIR}/cms/cmst)
endif()

add_custom_target(cms DEPENDS
  cmsfm
  cmsi
  cmst
)

get_target_property(cmsfm_modulePaths cmsfm CMAKE_MODULE_PATH)
if(NOT cmsfm_modulePaths)
  set(cmsfm_modulePaths)
endif()
get_target_property(cmsi_modulePaths cmsi CMAKE_MODULE_PATH)
if(NOT cmsi_modulePaths)
  set(cmsi_modulePaths)
endif()
get_target_property(cmst_modulePaths cmst CMAKE_MODULE_PATH)
if(NOT cmst_modulePaths)
  set(cmst_modulePaths)
endif()

set_property(TARGET cms PROPERTY CMAKE_MODULE_PATH
  ${cmsfm_modulePaths}
  ${cmsi_modulePaths}
  ${cmst_modulePaths}
)
