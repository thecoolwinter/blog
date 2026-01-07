// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "blog",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(path: "Dependencies/Ink"),
        .package(url: "https://github.com/Kitura/swift-html-entities.git", from: "3.0.0")
    ],
    targets: [
        .executableTarget(
            name: "blog",
            dependencies: [
                .product(name: "Ink", package: "ink"),
                .product(name: "HTMLEntities", package: "swift-html-entities")
            ]
        ),
    ]
)
