cmake_minimum_required(VERSION 3.6)
project(cmsfm)

add_custom_target(cmsfm)

set_target_properties(cmsfm
  PROPERTIES
    CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}
)
