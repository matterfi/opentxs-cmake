if(NOT MSVC)
  include(FindPkgConfig)
  pkg_check_modules(PC_SODIUM "libsodium")
  if(PC_SODIUM_FOUND)
    set(pkg_config_names_private "${pkg_config_names_private} libsodium")
  endif()
  if(NOT PC_SODIUM_FOUND)
    pkg_check_modules(PC_SODIUM "sodium")
    if(PC_SODIUM_FOUND)
      set(pkg_config_names_private "${pkg_config_names_private} sodium")
    endif()
  endif(NOT PC_SODIUM_FOUND)
  if(PC_SODIUM_FOUND)
    set(SODIUM_INCLUDE_HINTS ${PC_SODIUM_INCLUDE_DIRS}
                             ${PC_SODIUM_INCLUDE_DIRS}/*)
    set(SODIUM_LIBRARY_HINTS ${PC_SODIUM_LIBRARY_DIRS}
                             ${PC_SODIUM_LIBRARY_DIRS}/*)
  else()
    set(pkg_config_libs_private "${pkg_config_libs_private} -lsodium")
  endif()
endif(NOT MSVC)

find_path(SODIUM_INCLUDE_DIRS NAMES sodium.h HINTS ${SODIUM_INCLUDE_HINTS})

find_library(
  SODIUM_LIBRARIES
  NAMES libsodium sodium
  HINTS ${SODIUM_LIBRARY_HINTS}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
  SODIUM
  DEFAULT_MSG
  SODIUM_LIBRARIES
  SODIUM_INCLUDE_DIRS
)
mark_as_advanced(SODIUM_FOUND SODIUM_LIBRARIES SODIUM_INCLUDE_DIRS)
