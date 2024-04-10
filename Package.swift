// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftRouting",
    platforms: [.iOS(.v15), .macOS(.v12), .tvOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftRouting",
            targets: ["SwiftRouting"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftRouting",
            path: "Sources",
            resources: [.process("Resources/PrivacyInfo.xcprivacy")]),
        .testTarget(
            name: "SwiftRoutingTests",
            dependencies: ["SwiftRouting"])
    ]
)
