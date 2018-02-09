// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SoracomAPI",
    products: [
        .library(
            name: "SoracomAPI",
            targets: ["SoracomAPI"]
        ),
        .executable(
            name: "LinuxDemoAppForSoracomSDK",
            targets: ["LinuxDemoAppForSoracomSDK"]
        )
    ],
    targets: [
        .target(
            name: "SoracomAPI",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "SoracomAPITests",
            dependencies: ["SoracomAPI"],
            path: "Tests"
        ),
        .target(
            name: "LinuxDemoAppForSoracomSDK",
            dependencies: ["SoracomAPI"],
            path: "Whatever/LinuxDemoAppForSoracomSDK"
        )
    ]
)

// Note: There are also two other demo apps: one for macOS, and one for iOS.
// However, as of 2018-02-07, the Swift Package Manager does not yet support
// building regular macOS apps, or iOS apps, so they aren't listed here.
// They can be found in the ./Whatever directory.
