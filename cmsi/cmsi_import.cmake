cmake_minimum_required(VERSION 3.6)

# TODO: move the definition of a qualifying package name into the
# component-level documentation.

# TODO: Add a function which sets the CMAKE_MODULE_PATH property and can add
# transitive dependencies according to the documented convention.
# - cmsu: CMake Support Utilities
# - cmsu_mp: CMake Support Utilities Module Paths
# - cmsu_mp_getCMakeModulePath: return [] if there is none set.
# - cmsu_mp_setCMakeModulePath(<PATH> [INHERIT] [<TARGET1> [<TARGET2> ...]].

# TODO: Write a simple assertion lib.

# TODO: When a module is imported, also put its 'include' assets in scope.

# TODO: Unit tests and documentation for other things in this file.

# TODO: Rename this to something else. Maybe cmsi_il for import library? Maybe
# cmsu_il and consider this just another utility component?

# TODO: Move some of the general utilities from this file to elsewhere.

set(cmsi_import_PACKAGE_REGEX "^([a-zA-Z][a-zA-Z0-9][a-zA-Z0-9])[a-zA-Z0-9]+$")
set(cmsi_import_GROUP_REGEX "^[a-zA-Z][a-zA-Z0-9][a-zA-Z0-9]$")
set(cmsi_import_GROUP_ROOT_PATH "${CMAKE_CURRENT_LIST_DIR}/../..")

# Set the specified 'resultVar' to 'TRUE' if the specified 'str' meets the
# requirements of a package name, otherwise 'TRUE'. A string qualifies as a
# package name if it begins with an alphabetic character and is followed by at
# least three alphanumeric characters.
function(cmsi_import_isPackageName str resultVar)
  string(REGEX MATCH ${cmsi_import_PACKAGE_REGEX} _match ${str})
  if(_match STREQUAL "")
    set(${resultVar} FALSE PARENT_SCOPE)
  else()
    set(${resultVar} TRUE PARENT_SCOPE)
  endif()
endfunction()

# Set the specified 'resultVar' to 'TRUE' if the specified 'str' meets the
# requirements of a group name, otherwise 'TRUE'. A string qualifies as a
# group name if it begins with an alphabetic character and is followed by
# exactly two alphanumeric characters.
function(cmsi_import_isGroupName str resultVar)
  string(REGEX MATCH ${cmsi_import_GROUP_REGEX} _match ${str})
  if(_match STREQUAL "")
    set(${resultVar} FALSE PARENT_SCOPE)
  else()
    set(${resultVar} TRUE PARENT_SCOPE)
  endif()
endfunction()

# Set the specified 'resultVar' to the group name corresponding to the
# specified 'packageName'. The behavior us undefined unless 'packageName'
# qualifies as a package name.
function(cmsi_import_groupFromPackage packageName resultVar)
  cmsi_import_isPackageName("${packageName}" _isPackage)
  if(NOT ${_isPackage})
    message(SEND_ERROR "'${packageName}' does not qualify as a package name")
  endif()
  string(REGEX REPLACE ${cmsi_import_PACKAGE_REGEX} "\\1" _group ${packageName})
  set(${resultVar} ${_group} PARENT_SCOPE)
endfunction()

function(cmsi_importp packageName)
  cmsi_import_isPackageName("${packageName}" _isPackageName)
  if(NOT ${_isPackageName})
    message(SEND_ERROR "'${packageName}' does not qualify as a package name")
  endif()

  if(NOT TARGET ${packageName})
    cmsi_import_groupFromPackage(${packageName} groupName_)
    add_subdirectory(
      "${cmsi_import_GROUP_ROOT_PATH}/${groupName_}/${packageName}"
      ${CMAKE_BINARY_DIR}/${groupName_}/${packageName}
    )
    if(NOT TARGET ${packageName})
      message(SEND_ERROR
        "'${packageName}' didn't create a ${packageName} target"
      )
    endif()
  endif()
endfunction()

function(cmsi_import groupName)
  cmsi_import_isGroupName("${groupName}" _isGroupName)
  if(NOT ${_isGroupName})
    message(SEND_ERROR "'${groupName}' does not qualify as a group name")
  endif()

  if(NOT TARGET ${groupName})
    add_subdirectory(
      "${cmsi_import_GROUP_ROOT_PATH}/${groupName}"
      ${CMAKE_BINARY_DIR}/${groupName}
    )
    if(NOT TARGET ${groupName})
      message(SEND_ERROR
        "'${groupName}' didn't create a ${groupName} target"
      )
    endif()
  endif()
endfunction()

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
