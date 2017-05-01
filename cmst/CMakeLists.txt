cmake_minimum_required(VERSION 3.6)
project(cmst)

add_custom_target(cmst)

set_target_properties(cmst
  PROPERTIES
    CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}
)
