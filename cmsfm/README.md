# `cmsfm`

**PURPOSE:** Provide CMake Find Modules for third-party packages

**MNEMONIC:** CMake Support Find Modules (cmsfm)

## Description

The `cmsfm` package provides CMake Find Modules for several third-party
packages. These modules enable CMake projects to use these third-party
packages. This package is intended to compiliment the Find Modules that are
already included in the CMake distribution.

## Usage

To use the modules provided by this package, on needs to add them to the
`CMAKE_MODULE_PATH`. This is usually done early on in the top-level
`CMakeLists.txt`.

```
set(CMAKE_MODULE_PATH
  "${CMAKE_CURRENT_LIST_DIR}/cms/cmsfm;${CMAKE_MODULE_PATH}")
```

Once `CMAKE_MODULE_PATH` is set, one can use the normal `find_package` commands
to fetch them. For example, the following command calls the `FindASIO` module.

```
find_package(ASIO QUIET REQUIRED)
```

## Hierarchical Synopsis

The `cmsfm` package currently has 1 component having 1 level of physical
dependency.

```
1. FindASIO
```

## Component Synopsis

```
* `FindASIO`. Provide access to Chris Kohlhoff's ASIO library.
```
