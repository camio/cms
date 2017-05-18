#@PURPOSE: Provide utilities for the creation of CMake test drivers.
#
#@FUNCTIONS:
#   cmst_utd_check        verify that a predicate evaluates to TRUE
#   cmst_utd_endtest      mark the end of a test
#   cmst_utd_endtestsuite mark the end of a test suite
#   cmst_utd_fail         signal a test failure
#   cmst_utd_test         mark the beginning of a test
#   cmst_utd_testsuite    mark the beginning of a test suite
#
#@DESCRIPTION: This module includes several function which aid in the creation
# of test drivers that verify CMake modules. The look and feel of the API
# is similar to that of GTest.
#
# Execution of Test Drivers
# -------------------------
# Test Drivers are CMake modules like any other with the exception that they
# are intended to be run in "script" mode. That is, no configure or generate
# step is performaned and the cache is not modified. This somewhat limits what
# a test can do (e.g. it cannot create targets...
# TODO: mention what can be in scope at the test run.
# TODO: make a section for a convention to add unit tests to ctest.
#
# Usage
# -----
# This section illustrates intended use of this component.
#
# Example 1:
# - - - - -
# The test drivers, when run using 'cmake -P', have
# an output similar to that of GTest. The test drivers return a '0' if all
# tests passed or a non-zero value if there's a test failure.

cmake_minimum_required(VERSION 3.6)

function(cmst_utd_setGlobal_ varName varValue)
  set(${varName} ${varValue} CACHE INTERNAL "" FORCE)
endfunction()

function(cmst_utd_updateGlobal_ varName)
  set(${varName} ${${varName}} CACHE INTERNAL "" FORCE)
endfunction()

cmst_utd_setGlobal_(cmst_utd_numTests_ 0)
cmst_utd_setGlobal_(cmst_utd_numSuccessfulTests_ 0)
cmst_utd_setGlobal_(cmst_utd_numFailedTests_ 0)
cmst_utd_setGlobal_(cmst_utd_failedTests_ "")

function(cmst_utd_test testName)
  cmst_utd_setGlobal_(cmst_utd_currentTestName_ "${cmst_utd_currentTestSuiteName_}.${testName}")
  math(EXPR cmst_utd_numTests_ "${cmst_utd_numTests_} + 1")
  cmst_utd_updateGlobal_(cmst_utd_numTests_)
  cmst_utd_setGlobal_(cmst_utd_currentTestNumFailures_ 0)
  message(STATUS "[ RUN      ] ${cmst_utd_currentTestName_}")
endfunction()

function(cmst_utd_endtest)
  if(cmst_utd_currentTestNumFailures_ EQUAL 0)
    math(EXPR cmst_utd_numSuccessfulTests_ "${cmst_utd_numSuccessfulTests_} + 1")
    cmst_utd_updateGlobal_(cmst_utd_numSuccessfulTests_)

    message(STATUS "[       OK ] ${cmst_utd_currentTestName_}")
  else()
    list(APPEND cmst_utd_failedTests_ "${cmst_utd_currentTestName_}")
    cmst_utd_updateGlobal_(cmst_utd_failedTests_)
    math(EXPR cmst_utd_numFailedTests_ "${cmst_utd_numFailedTests_} + 1")
    cmst_utd_updateGlobal_(cmst_utd_numFailedTests_)

    message(STATUS "[  FAILED  ] ${cmst_utd_currentTestName_}")
  endif()
endfunction()

function(cmst_utd_fail msg)
  math(EXPR cmst_utd_currentTestNumFailures_ "${cmst_utd_currentTestNumFailures_} + 1")
  cmst_utd_updateGlobal_(cmst_utd_currentTestNumFailures_)
  message(STATUS ${msg})
endfunction()

function(cmst_utd_check)
  math(EXPR _msgIndex "${ARGC} - 1")
  set(_predicate ${ARGV})
  list(REMOVE_AT _predicate ${_msgIndex})
  list(GET ARGV ${_msgIndex} _msg)

  if(${_predicate})
  else()
    cmst_utd_fail("Failure: ${_msg}")
  endif()
endfunction()

function(cmst_utd_testsuite testSuiteName)
  cmst_utd_setGlobal_(cmst_utd_currentTestSuiteName_ "${testSuiteName}")
  message(STATUS "[==========] Running tests.")
endfunction()

function(cmst_utd_endtestsuite)
  message(STATUS "[==========] ${cmst_utd_numTests_} tests ran.")
  if(${cmst_utd_numSuccessfulTests_} GREATER 0)
    if(${cmst_utd_numSuccessfulTests_} EQUAL 1)
      set(_test "test")
    else()
      set(_test "tests")
    endif()
    message(STATUS "[  PASSED  ] ${cmst_utd_numSuccessfulTests_} ${_test}.")
  endif()
  if(${cmst_utd_numFailedTests_} GREATER 0)
    if(${cmst_utd_numFailedTests_} EQUAL 1)
      set(_test "test")
    else()
      set(_test "tests")
    endif()
    message(STATUS "[  FAILED  ] ${cmst_utd_numFailedTests_} ${_test}, listed below:")
    foreach(failedTest IN LISTS cmst_utd_failedTests_)
      message(STATUS "[  FAILED  ] ${failedTest}")
    endforeach()
    message(FATAL_ERROR "")
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
