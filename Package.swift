// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Qrdnicapacitor",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "Qrdnicapacitor",
            targets: ["qrdniPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "8.0.0")
    ],
    targets: [
        .target(
            name: "qrdniPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/qrdniPlugin"),
        .testTarget(
            name: "qrdniPluginTests",
            dependencies: ["qrdniPlugin"],
            path: "ios/Tests/qrdniPluginTests")
    ]
)