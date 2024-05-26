// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "RealityUI",
    platforms: [.visionOS(.v1), .iOS(.v17), .macOS(.v14)],
    products: [
        .library(
            name: "RealityUI",
            targets: ["RealityUI"]
        ),
        .library(
            name: "Charts3D",
            targets: ["Charts3D"]
        ),
        .library(
            name: "ColorPalette",
            targets: ["ColorPalette"]
        ),

    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0"),
    ],
    targets: [
        .target(
            name: "RealityUI",
            dependencies: [
                "ColorPalette",
                .product(name: "Algorithms", package: "swift-algorithms"),
            ]
        ),
        .testTarget(
            name: "RealityUITests",
            dependencies: ["RealityUI"]
        ),
        .target(
            name: "Charts3D",
            dependencies: ["RealityUI"]
        ),
        .testTarget(
            name: "Charts3DTests",
            dependencies: ["Charts3D"]
        ),
        .target(
            name: "ColorPalette"
        ),
    ]
)
