// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "blog",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/johnsundell/ink.git", from: "0.6.0")
    ],
    targets: [
        .executableTarget(
            name: "blog",
            dependencies: [.product(name: "Ink", package: "ink")]
        ),
    ]
)
