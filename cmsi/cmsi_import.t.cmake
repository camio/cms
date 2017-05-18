cmake_minimum_required(VERSION 3.6)

include(cmsi_import)
include(cmst_utd)

cmst_utd_testsuite(cmsi_import)
  cmst_utd_test(isPackageName)
    cmsi_import_isPackageName(bde o)
    cmst_utd_check(DEFINED o "'o' wasn't set.")
    cmst_utd_check(NOT ${o} "Unexpected result '${o}'")
    unset(o)

    cmsi_import_isPackageName(bdest o)
    cmst_utd_check(DEFINED o "'o' wasn't set.")
    cmst_utd_check("${o}" "Unexpected result '${o}'")
    unset(o)

    cmsi_import_isPackageName(b99t o)
    cmst_utd_check(DEFINED o "'o' wasn't set.")
    cmst_utd_check("${o}" "Unexpected result '${o}'")
    unset(o)

    cmsi_import_isPackageName(9det o)
    cmst_utd_check(DEFINED o "'o' wasn't set.")
    cmst_utd_check(NOT "${o}" "Unexpected result '${o}'")
    unset(o)

    cmsi_import_isPackageName(d_et o)
    cmst_utd_check(DEFINED o "'o' wasn't set.")
    cmst_utd_check(NOT "${o}" "Unexpected result '${o}'")
    unset(o)

    cmsi_import_isPackageName(bdee_t o)
    cmst_utd_check(DEFINED o "'o' wasn't set.")
    cmst_utd_check(NOT "${o}" "Unexpected result '${o}'")
    unset(o)
  cmst_utd_endtest()

  cmst_utd_test(isGroupName)
    cmsi_import_isGroupName("b" o)
    cmst_utd_check(DEFINED o "'o' wasn't set.")
    cmst_utd_check(NOT "${o}" "Unexpected result '${o}'")
    unset(o)

    cmsi_import_isGroupName("bde" o)
    cmst_utd_check(DEFINED o "'o' wasn't set.")
    cmst_utd_check("${o}" "Unexpected result '${o}'")
    unset(o)

    cmsi_import_isGroupName("bd9" o)
    cmst_utd_check(DEFINED o "'o' wasn't set.")
    cmst_utd_check("${o}" "Unexpected result '${o}'")
    unset(o)

    cmsi_import_isGroupName("9de" o)
    cmst_utd_check(DEFINED o "'o' wasn't set.")
    cmst_utd_check(NOT "${o}" "Unexpected result '${o}'")
    unset(o)

    cmsi_import_isGroupName("b_e" o)
    cmst_utd_check(DEFINED o "'o' wasn't set.")
    cmst_utd_check(NOT "${o}" "Unexpected result '${o}'")
    unset(o)

    cmsi_import_isGroupName("bdee" o)
    cmst_utd_check(DEFINED o "'o' wasn't set.")
    cmst_utd_check(NOT "${o}" "Unexpected result '${o}'")
    unset(o)
  cmst_utd_endtest()

  cmst_utd_test(groupFromPackage)
    cmsi_import_groupFromPackage(test o)
    cmst_utd_check(DEFINED o "'o' wasn't set.")
    cmst_utd_check("${o}" STREQUAL "tes" "Expected 'tes', but received '${o}'")
  cmst_utd_endtest()
cmst_utd_endtestsuite()

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
