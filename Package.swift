// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "SwiftSyntaxWrapper",
    products: [
        .library(name: "SwiftSyntaxWrapper", targets: ["SwiftSyntaxWrapper"]),
    ],
    targets: [
        .binaryTarget(
            name: "SwiftSyntaxWrapper",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/600.0.1/SwiftSyntaxWrapper.xcframework.zip",
            checksum: "1fcd4a7b144284934801a67064e85d2641efd1128ef8efb42a51855f0d586329"
        ),
    ]
)
