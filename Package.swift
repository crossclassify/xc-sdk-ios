// swift-tools-version:5.0
//
// CrossClassify
//

import PackageDescription

let package = Package(
  name: "CrossClassify",
  products: [
      .library(name: "CrossClassify", targets: ["CrossClassify"])
  ],
  targets: [
      .target(name: "CrossClassify", dependencies: [], path: "CrossClassify"),
  ],
  swiftLanguageVersions: [.v5]
)
