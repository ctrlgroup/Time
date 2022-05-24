// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Time",
  platforms: [ .iOS(.v13), .macOS(.v10_14) ],
  products: [
    .library(name: "Time", targets: ["Time"]),
    .library(name: "TimeTestHelpers", targets: ["TimeTestHelpers"])
  ],
  dependencies: [
    .package(url: "https://github.com/ctrlgroup/Resolver.git",
             branch: "feature/moc-view-context-constant"),
    .package(url: "https://github.com/Quick/Quick.git", from: "4.0.0"),
    .package(url: "https://github.com/Quick/Nimble.git", from: "9.2.1")
  ],
  targets: [
    .target(name: "Time", dependencies: ["Resolver"]),
    .target(name: "TimeTestHelpers", dependencies: ["Time"]),
    .testTarget(name: "TimeTests", dependencies: [
      "Quick",
      "Nimble",
      "Time",
      "TimeTestHelpers"
    ])
  ]
)
