// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "LinuxDemoAppForSoracomSDK",
    dependencies: [
        .package(url: "../..", .branch( "add-linux-support") ),
    ],
    targets: [
        .target(
            name: "LinuxDemoAppForSoracomSDK", 
            dependencies: [
                "SoracomSDKSwift"
            ],
            path: "Sources"
        )
    ]
)
