// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KeyAppKit",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),

    ],
    products: [
        .library(name: "Cache", targets: ["Cache"]),
        .library(
            name: "TransactionParser",
            targets: ["TransactionParser"]
        ),
        .library(
            name: "NameService",
            targets: ["NameService"]
        ),
        // Analytics manager for wallet
        .library(
            name: "AnalyticsManager",
            targets: ["AnalyticsManager"]
        ),
        // Price service for wallet
        .library(
            name: "SolanaPricesAPIs",
            targets: ["SolanaPricesAPIs"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/p2p-org/solana-swift", from: "2.1.1"),
        .package(name: "Amplitude", url: "https://github.com/amplitude/Amplitude-iOS", from: "8.3.0")
    ],
    targets: [
        .target(name: "Cache"),
        .target(
            name: "TransactionParser",
            dependencies: [
                "Cache",
                .product(name: "SolanaSwift", package: "solana-swift"),
            ]
        ),
        .testTarget(
            name: "TransactionParserUnitTests",
            dependencies: ["TransactionParser"],
            path: "Tests/UnitTests/TransactionParserUnitTests",
            resources: [.process("./Resource")]
        ),
        .target(
            name: "NameService",
            dependencies: []
        ),
        .target(
            name: "JSBridge"
        ),
        .testTarget(
            name: "NameServiceIntegrationTests",
            dependencies: [
                "NameService",
                .product(name: "SolanaSwift", package: "solana-swift")
            ],
            path: "Tests/IntegrationTests/NameServiceIntegrationTests"
        ),
        // AnalyticsManager
        .target(
            name: "AnalyticsManager",
            dependencies: ["Amplitude"]
        ),
        .testTarget(
            name: "AnalyticsManagerUnitTests",
            dependencies: ["AnalyticsManager"],
            path: "Tests/UnitTests/AnalyticsManagerUnitTests"
        ),
        // PricesService
        .target(
            name: "SolanaPricesAPIs",
            dependencies: ["Cache", .product(name: "SolanaSwift", package: "solana-swift"),]
        ),
        .testTarget(
            name: "SolanaPricesAPIsUnitTests",
            dependencies: ["SolanaPricesAPIs"],
            path: "Tests/UnitTests/SolanaPricesAPIsUnitTests"
            //      resources: [.process("./Resource")]
        ),
    ]
)

#if swift(>=5.6)
    // For generating docs purpose
    // package.dependencies.append(.package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"))
#endif
