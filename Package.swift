// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SoracomAPI",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SoracomAPI",
            targets: ["SoracomAPI"]
        ),
        .executable(
            name: "SoracomAPIDemo",
            targets: ["SoracomAPIDemo"]
        )
    ],
    dependencies: [
        // none
    ],
    targets: [
        .target(
            name: "SoracomAPI",
            dependencies: []
        ),
        .target(
            name: "SoracomAPIDemo",
            dependencies: ["SoracomAPI"]
        ),
        .testTarget(
            name: "SoracomAPITests",
            dependencies: ["SoracomAPI"]),
    ]
)
