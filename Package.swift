// swift-tools-version:4.0

// Mason 2016-04-10: We will eventually be a Swift Package Manager package (Swift 3), but as of right now, the intended use case is Xcode 7.3 and Swift 2.x.

import PackageDescription

let package = Package(
    name: "SoracomSDKSwift",
    targets: [
        .target(
            name: "SoracomSDKSwift",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "SoracomSDKSwiftTests",
            dependencies: [],
            path: "Tests"
        )
    ]
)

