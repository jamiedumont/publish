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
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.8.0"),
        .package(name: "MagickPublishPlugin", url: "https://github.com/mvolpato/magickpublishplugin", from: "0.3.0"),
        .package(name: "VerifyResourcesExistPublishPlugin", url: "https://github.com/wacumov/VerifyResourcesExistPublishPlugin", from: "0.1.0"),
        .package(name: "LocalWebsitePublishPlugin", url: "https://github.com/Deub27/LocalWebsitePublishPlugin.git", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "JamieDumont",
            dependencies: [
                "Publish",
                "MagickPublishPlugin",
                "VerifyResourcesExistPublishPlugin",
                "LocalWebsitePublishPlugin"
            ]
        )
    ]
)
