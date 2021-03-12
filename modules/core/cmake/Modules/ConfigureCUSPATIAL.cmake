#=============================================================================
# Copyright (c) 2021, NVIDIA CORPORATION.
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
#=============================================================================

function(find_and_configure_cuspatial VERSION)

    include(get_cpm)

    CPMAddPackage(NAME  cuspatial
        VERSION         ${VERSION}
        # GIT_REPOSITORY https://github.com/rapidsai/cuspatial.git
        # GIT_TAG        branch-${VERSION}
        GIT_REPOSITORY  https://github.com/trxcllnt/cuspatial.git
        # Can also use a local path to your repo clone for testing
        # GIT_REPOSITORY  /home/ptaylor/dev/rapids/cuspatial
        GIT_TAG         fix/cmake-exports
        GIT_SHALLOW     TRUE
        SOURCE_SUBDIR   cpp
        OPTIONS         "BUILD_TESTS OFF"
                        "BUILD_BENCHMARKS OFF"
                        "JITIFY_USE_CACHE ON"
                        "CUDA_STATIC_RUNTIME ON"
                        "CUDF_USE_ARROW_STATIC ON"
                        "PER_THREAD_DEFAULT_STREAM ON"
                        "DISABLE_DEPRECATION_WARNING ${DISABLE_DEPRECATION_WARNINGS}")

    # Make sure consumers of our libs can also see cuspatial::cuspatial
    if(TARGET cuspatial::cuspatial)
        get_target_property(cuspatial_is_imported cuspatial::cuspatial IMPORTED)
        if(cuspatial_is_imported)
            set_target_properties(cuspatial::cuspatial PROPERTIES IMPORTED_GLOBAL TRUE)
        endif()
    endif()
endfunction()

find_and_configure_cuspatial(${CUSPATIAL_VERSION})
