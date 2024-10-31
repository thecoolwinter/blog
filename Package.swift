// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "blog",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(path: "Dependencies/Ink")
    ],
    targets: [
        .executableTarget(
            name: "blog",
            dependencies: [
                .product(name: "Ink", package: "ink")
            ]
        ),
    ]
)
