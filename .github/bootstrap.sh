#!/bin/bash

SWIFT_SYNTAX_VERSION=$1
RELEVANT_PRODUCTS=${@:2}
SWIFT_SYNTAX_NAME="swift-syntax"
SWIFT_SYNTAX_REPOSITORY_URL="https://github.com/apple/$SWIFT_SYNTAX_NAME.git"
SEMVER_PATTERN="^[0-9]+\.[0-9]+\.[0-9]+$"
WRAPPER_PACKAGE_NAME="SwiftSyntaxWrapper"

#
# Verify input
#

if [ -z "$SWIFT_SYNTAX_VERSION" ]; then
    echo "Swift syntax version (git tag) must be supplied as the first argument"
    exit 1
fi

if ! [[ $SWIFT_SYNTAX_VERSION =~ $SEMVER_PATTERN ]]; then
    echo "The given version ($SWIFT_SYNTAX_VERSION) does not have the right format (expected X.Y.Z)."
    exit 1
fi

if [ -z "$RELEVANT_PRODUCTS" ]; then
    echo "Specify at least one product name to build."
    exit 1
fi

#
# Print input
#

cat << EOF

Input:
swift-syntax version to build:  $SWIFT_SYNTAX_VERSION
products to build:              $RELEVANT_PRODUCTS

EOF

set -eux

#
# Clone package
#

git clone --branch $SWIFT_SYNTAX_VERSION --single-branch $SWIFT_SYNTAX_REPOSITORY_URL

#
# Add _SwiftSyntaxTestSupport to products so that unit test targets are also supported
#

sed -i '' -E 's/(products: \[)$/\1\n    .library(name: "_SwiftSyntaxTestSupport", targets: ["_SwiftSyntaxTestSupport"]),/g' "$SWIFT_SYNTAX_NAME/Package.swift"

#
# Build static libraries
#

sed -i '' 's/, targets:/, type: .static, targets:/g' "$SWIFT_SYNTAX_NAME/Package.swift"
swift build --package-path $SWIFT_SYNTAX_NAME --arch arm64 -c debug -Xswiftc -enable-library-evolution -Xswiftc -emit-module-interface

#
# Create XCFrameworks
#

for PRODUCT_NAME in $RELEVANT_PRODUCTS; do

    PATH_TO_LIBRARY="$SWIFT_SYNTAX_NAME/.build/arm64-apple-macosx/debug/lib$PRODUCT_NAME.a"
    PATH_TO_INTERFACE="$SWIFT_SYNTAX_NAME/.build/arm64-apple-macosx/debug/$PRODUCT_NAME.build/$PRODUCT_NAME.swiftinterface"
    XCFRAMEWORK_NAME="$PRODUCT_NAME.xcframework"

    if ! [ -f "$PATH_TO_LIBRARY" ]; then
        echo "library does not exist."
        exit 1
    fi

    if ! [ -f "$PATH_TO_INTERFACE" ]; then
        echo "interface does not exist."
        exit 1
    fi

    xcodebuild -create-xcframework -library $PATH_TO_LIBRARY -output $XCFRAMEWORK_NAME
    cp $PATH_TO_INTERFACE $XCFRAMEWORK_NAME/macos-arm64
    zip --quiet --recurse-paths $XCFRAMEWORK_NAME.zip $XCFRAMEWORK_NAME
done

#
# Create package manifest
#

tee Package.swift <<EOF
// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "$WRAPPER_PACKAGE_NAME",
    products: [
        .library(
            name: "$WRAPPER_PACKAGE_NAME",
            targets: [
EOF

for PRODUCT_NAME in $RELEVANT_PRODUCTS; do
    echo "                \"$PRODUCT_NAME\"," >> Package.swift
done

tee -a Package.swift <<EOF
            ]
        )
    ],
    targets: [
EOF

for PRODUCT_NAME in $RELEVANT_PRODUCTS; do
    CHECKSUM=$(swift package compute-checksum $PRODUCT_NAME.xcframework.zip)
    URL="$GITHUB_SERVER_URL/$GITHUB_REPOSITORY/releases/download/$SWIFT_SYNTAX_VERSION/$PRODUCT_NAME.xcframework.zip"

    tee -a Package.swift <<EOF
        .binaryTarget(
            name: "$PRODUCT_NAME",
            url: "$URL",
            checksum: "$CHECKSUM"
        ),
EOF
done

tee -a Package.swift <<EOF
    ]
)
EOF

#
# Create rest of dummy package
#

mkdir -p Sources/$WRAPPER_PACKAGE_NAME
touch Sources/$WRAPPER_PACKAGE_NAME/Empty.swift
