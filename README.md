# `cms`

**PURPOSE:** Provide CMake support libraries

**MNEMONIC:** CMake Support (cms)

## Description

The `cms` ("CMake support") package group contains CMake packages that support
building for the Bloomberg environment.

## Hierarchical Synopsis

The `dpl` package group currently has 1 packages having 1 level of physical
dependency. The list below shows the hierarchical ordering of the packages.

```
1. cmsfm
```

## Package Overview

This section is a brief introduction to the packages of the `cmsfm` package
group.  See the respective Package Level documents for more details.

### `cmsfm`

The `cmsfm` package provides CMake Find Modules for several third-party
packages. These modules enable CMake projects to use these third-party
packages. This package is intended to compiliment the Find Modules that are
already included in the CMake distribution.

## Target conventions

TODO: Document the additional conventions that go beyond cmake. In particular,
we can use a convention that a target name can bring with it, as a property, a
list of module paths that it provides for use in the `include` command
( `CMAKE_MODULE_PATH` property includes assets and all (including transitive)
dependencies. )

TODO: Document what you'd expect for imports in a package group, package, etc.
