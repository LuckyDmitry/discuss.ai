// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Analytics",
  platforms: [.iOS(.v16)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    
    .library(
      name: "Analytics",
      type: .static,
      targets: ["Analytics"]),
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/firebase-ios-sdk", from: .init(10, 7, 0))
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(
      name: "Analytics",
      dependencies: [
        .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
      ]
    )
  ]
)
