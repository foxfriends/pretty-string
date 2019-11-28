// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "PrettyString",
  products: [
    .library(name: "PrettyString", targets: ["PrettyString"]),
  ],
  dependencies: [],
  targets: [
    .target(name: "PrettyString", dependencies: []),
  ]
)
