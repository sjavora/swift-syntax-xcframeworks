# Swift Syntax XCFrameworks

This respository is a proof-of-concept for building packages that depend on [`swift-syntax`](https://github.com/apple/swift-syntax.git) (like macros) without having to also build `swift-syntax`. This is accomplished by prebuilding the libraries of `swift-syntax` and vending them via the `SwiftSyntaxWrapper` package.

Using these prebuilt libraries is a way of eliminating the compile time overhead of `swift-syntax`.

## Getting started

### Create a new macro package, either from Xcode, or Terminal by typing

```
swift package init --type macro
```

### Modify the package manifest

#### Swap `swift-syntax` dependency for `swift-syntax-xcframeworks`

Replace

```
.package(url: "https://github.com/apple/swift-syntax.git", from: "<some version>"),
```

with

```
.package(url: "https://github.com/sjavora/swift-syntax-xcframeworks.git", from: "<some version>"),
```

#### Update target dependencies with `SwiftSyntaxWrapper`

Replace

```
.product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
.product(name: "SwiftCompilerPlugin", package: "swift-syntax")
```

and

```
.product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
```

with

```
.product(name: "SwiftSyntaxWrapper", package: "swift-syntax-xcframeworks"),
```

### Run the package

The package should now build, tests should run, and the macro in the client should expand correctly.

## Compile time comparison

The purpose of this repository is to be able to use `swift-syntax` while eliminating its compile time. Compare Xcode's build timeline for the default macro package with and without building `swift-syntax`:

| with `swift-syntax` (18s 72ms) | with `swift-syntax-frameworks` (2s 28ms) |
| ------------------- | -------------------------------|
| ![Build timeline when building with swift-syntax from source, total duration of 18s 72ms](https://github.com/sjavora/swift-syntax-xcframeworks/assets/12349477/d6ca41cd-b56b-4623-90f0-673bab71a6a6) | ![Build timeline when using swift-syntax-xcframeworks, total duration of 2s 28ms](https://github.com/sjavora/swift-syntax-xcframeworks/assets/12349477/b14d4c21-136b-46dd-b570-584d6d726b7d) |

Measured on a MacBook Pro with M1 Pro and 32 GB RAM, running Xcode 15.0.

## Known issues

### Warnings

The linker produces a warning about duplicate libraries. This is only visible when building the macro package itself, though, not when using the macro in some other package. This doesn't seem to cause issues in practice.

### Clashes with `swift-syntax`

If your project depends on `swift-syntax` in any way (e.g., through a third party library), Xcode will fail package resolution due to name clashes. A possible workaround woudl be to rename all the products when building `swift-syntax` in this repository to avoid such clashes, though that would then require renaming all the imports in files that use `SwiftSyntaxWrapper`.
