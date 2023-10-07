// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CrossClassify",
    platforms: [.iOS("13.0")],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CrossClassify",
            targets: ["CrossClassify"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/fingerprintjs/fingerprintjs-pro-ios", from: "2.0.0"),
        .package(url: "https://github.com/fingerprintjs/fingerprintjs-ios", from: "1.4.1"),
//        .package(url: "https://github.com/google/google-api-objectivec-client-for-rest.git", from: "3.1.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CrossClassify",
            dependencies: [
                .product(name: "FingerprintPro", package: "fingerprintjs-pro-ios"),
                .product(name: "FingerprintJS", package: "fingerprintjs-ios"),
//                .product(name: "GoogleAPIClientForREST", package: "google-api-objectivec-client-for-rest.git"),
            ],
            exclude: ["Example"]
        ),
        .testTarget(
            name: "CrossClassifyTests",
            dependencies: ["CrossClassify"],
            exclude: ["Example"]
        ),
    ]
)
