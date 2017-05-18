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

# ----------------------------------------------------------------------------
# Copyright 2017 Bloomberg Finance L.P.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
