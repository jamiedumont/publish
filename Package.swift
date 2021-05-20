// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "JamieDumont",
    products: [
        .executable(
            name: "JamieDumont",
            targets: ["JamieDumont"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.8.0")
    ],
    targets: [
        .target(
            name: "JamieDumont",
            dependencies: ["Publish"]
        )
    ]
)
