// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "amplify-mapkit-example",
    platforms: [
        .iOS(.v13),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "amplify-mapkit-example",
            targets: ["amplify-mapkit-example"]),
    ],
    dependencies: [
         .package(url: "https://github.com/aws-amplify/amplify-swift", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "amplify-mapkit-example",
            dependencies: [
                .product(name: "Amplify", package: "amplify-swift")
            ]),
        .testTarget(
            name: "amplify-mapkit-exampleTests",
            dependencies: ["amplify-mapkit-example"]),
    ]
)
