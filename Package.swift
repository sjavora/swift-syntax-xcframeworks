// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SwiftSyntaxWrapper",
    products: [
        .library(
            name: "SwiftSyntaxWrapper",
            targets: [
                "SwiftBasicFormat",
                "SwiftCompilerPlugin",
                "SwiftCompilerPluginMessageHandling",
                "SwiftDiagnostics",
                "SwiftIDEUtils",
                "SwiftOperators",
                "SwiftParser",
                "SwiftParserDiagnostics",
                "SwiftRefactor",
                "SwiftSyntax",
                "SwiftSyntaxBuilder",
                "SwiftSyntaxMacros",
                "SwiftSyntaxMacroExpansion",
                "SwiftSyntaxMacrosTestSupport",
                "_SwiftSyntaxTestSupport",
            ]
        )
    ],
    targets: [
        .binaryTarget(
            name: "SwiftBasicFormat",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/SwiftBasicFormat.xcframework.zip",
            checksum: "73b0ba22e13286bcb4e327056162f4521db354049d205b485dd01a83f640215d"
        ),
        .binaryTarget(
            name: "SwiftCompilerPlugin",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/SwiftCompilerPlugin.xcframework.zip",
            checksum: "f014b9187486f85eef30ed977dbccde7e7513adec9a5d7195b8698b3eb339cfd"
        ),
        .binaryTarget(
            name: "SwiftCompilerPluginMessageHandling",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/SwiftCompilerPluginMessageHandling.xcframework.zip",
            checksum: "7d2271a2bd57e88198cb9bfb4a4b2199efe186afc4c28f55d9f46fc355ccdaff"
        ),
        .binaryTarget(
            name: "SwiftDiagnostics",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/SwiftDiagnostics.xcframework.zip",
            checksum: "95bf79087c96cadf6366c461e2186c485f48ea202edc064fb811df701e16afe2"
        ),
        .binaryTarget(
            name: "SwiftIDEUtils",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/SwiftIDEUtils.xcframework.zip",
            checksum: "325a22994d14c8ffcbe7de1c0ca8b6ebafdc82829649d37bfb95b30bdabdb67d"
        ),
        .binaryTarget(
            name: "SwiftOperators",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/SwiftOperators.xcframework.zip",
            checksum: "6d797ab37840a778e4d29fa783b069851b6d47d786307d0d2017c8be843d7935"
        ),
        .binaryTarget(
            name: "SwiftParser",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/SwiftParser.xcframework.zip",
            checksum: "cf2ba192f47a5e6cac3e9a6f5c10337bd2c090221b9ff6ff174d9969963b22cf"
        ),
        .binaryTarget(
            name: "SwiftParserDiagnostics",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/SwiftParserDiagnostics.xcframework.zip",
            checksum: "977b43b5e8abd30823aa6fc94cf02d67c8b100c451a169bc1b0dbdf6eb4fdeb2"
        ),
        .binaryTarget(
            name: "SwiftRefactor",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/SwiftRefactor.xcframework.zip",
            checksum: "b5a6dcf60e28ae59ca098c33b8d1812bf34c08b3c7c8698ceb70dff18b5ed3c6"
        ),
        .binaryTarget(
            name: "SwiftSyntax",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/SwiftSyntax.xcframework.zip",
            checksum: "08a7b0f0c163c69abd69acfcbaf68ae2b41f3420d97fdeb0752d987d63676b41"
        ),
        .binaryTarget(
            name: "SwiftSyntaxBuilder",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/SwiftSyntaxBuilder.xcframework.zip",
            checksum: "99f03a1076750fdb3020f5f3c1198a26bce727a78a7ae213c60c6ffb2769be30"
        ),
        .binaryTarget(
            name: "SwiftSyntaxMacros",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/SwiftSyntaxMacros.xcframework.zip",
            checksum: "2bf06a7911a8b0a0ad911421de9227bf5becfe384504bf8258df15909780314f"
        ),
        .binaryTarget(
            name: "SwiftSyntaxMacroExpansion",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/SwiftSyntaxMacroExpansion.xcframework.zip",
            checksum: "3dca335695ca203e869589442311db34c2c27e9b6c7bf6902937e5a5a5fc9f6a"
        ),
        .binaryTarget(
            name: "SwiftSyntaxMacrosTestSupport",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/SwiftSyntaxMacrosTestSupport.xcframework.zip",
            checksum: "508e6a38d6ba7cf83cc3a6d42270087b4b35bd4138453ca4f0a92261ffbc0e2a"
        ),
        .binaryTarget(
            name: "_SwiftSyntaxTestSupport",
            url: "https://github.com/sjavora/swift-syntax-xcframeworks/releases/download/509.0.2/_SwiftSyntaxTestSupport.xcframework.zip",
            checksum: "242309a94246428aa8088c45cc27fcee7d30df955a6afcc0ec5c46079c51ef20"
        ),
    ]
)
