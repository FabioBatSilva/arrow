# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

pkg_check_modules(uriparser_PC liburiparser)
if(uriparser_PC_FOUND)
  set(uriparser_INCLUDE_DIR "${uriparser_PC_INCLUDEDIR}")

  list(APPEND uriparser_PC_LIBRARY_DIRS "${uriparser_PC_LIBDIR}")
  find_library(uriparser_LIB uriparser
               PATHS ${uriparser_PC_LIBRARY_DIRS}
               NO_DEFAULT_PATH
               PATH_SUFFIXES "${CMAKE_LIBRARY_ARCHITECTURE}")
elseif(uriparser_ROOT)
  message(STATUS "Using uriparser_ROOT: ${uriparser_ROOT}")
  find_library(uriparser_LIB
               NAMES uriparser
               PATHS ${uriparser_ROOT}
               PATH_SUFFIXES ${LIB_PATH_SUFFIXES}
               NO_DEFAULT_PATH)
  find_path(uriparser_INCLUDE_DIR
            NAMES uriparser/Uri.h
            PATHS ${uriparser_ROOT}
            NO_DEFAULT_PATH
            PATH_SUFFIXES ${INCLUDE_PATH_SUFFIXES})
else()
  find_library(uriparser_LIB
               NAMES uriparser
               PATH_SUFFIXES ${LIB_PATH_SUFFIXES})
  find_path(uriparser_INCLUDE_DIR NAMES uriparser/Uri.h PATH_SUFFIXES ${INCLUDE_PATH_SUFFIXES})
endif()

find_package_handle_standard_args(uriparser REQUIRED_VARS uriparser_LIB uriparser_INCLUDE_DIR)

if(uriparser_FOUND)
  add_library(uriparser::uriparser UNKNOWN IMPORTED)
  set_target_properties(uriparser::uriparser
                        PROPERTIES IMPORTED_LOCATION "${uriparser_LIB}"
                                   INTERFACE_INCLUDE_DIRECTORIES "${uriparser_INCLUDE_DIR}")
endif()
