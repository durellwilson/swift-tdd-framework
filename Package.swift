// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SwiftTDDFramework",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(name: "SwiftTDDFramework", targets: ["SwiftTDDFramework"]),
    ],
    targets: [
        .target(name: "SwiftTDDFramework"),
        .testTarget(name: "SwiftTDDFrameworkTests", dependencies: ["SwiftTDDFramework"]),
    ]
)
