// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "blog",
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.1.0")
    ],
    targets: [
        .executableTarget(
            name: "blog",
            dependencies: [.product(name: "Publish", package: "publish")]
        ),
    ]
)
