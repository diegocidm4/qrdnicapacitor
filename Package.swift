// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Qrdnicapacitor",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Qrdnicapacitor",
            targets: ["qrdniPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", from: "8.0.0"),
        .package(url: "https://github.com/diegocidm4/iQRDNI.git", from: "1.0.3")
        // ,
        //.package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", exact: "1.6.0")
    ],
    targets: [
        .target(
            name: "qrdniPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm"),
                .product(name: "iQRDNI", package: "iQRDNI")
                //,
                //.product(name: "CryptoSwift", package: "CryptoSwift")
            ],
            path: "ios/Sources/qrdniPlugin"),
        .testTarget(
            name: "qrdniPluginTests",
            dependencies: ["qrdniPlugin"],
            path: "ios/Tests/qrdniPluginTests")
    ]
)