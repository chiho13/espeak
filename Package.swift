// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "espeak-ng",
    products: [
        .library(name: "libespeak-ng", targets: ["libespeak-ng"]),
        .library(name: "espeak-ng-data", targets: ["data"]),
    ],
    targets: [
        .target(
            name: "libsonic",
            exclude: [ "_repo" ],
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("../onnxruntime/include"), // existing onnxruntime path
            ]
        ),
        .target(
            name: "libucd",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("../onnxruntime/include"), // existing onnxruntime path
            ]
        ),
        .target(
            name: "data",
            resources: [
                .copy("espeak-ng-data"),
                .copy("phsource"),
                .copy("dictsource"),
            ]
        ),
        .target(
            name: "libespeak-ng",
            dependencies: [ "libsonic", "libucd" ],
            exclude: [
                "_repo",
            ],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("."),
                .headerSearchPath("_repo/src/include"),
                .headerSearchPath("../onnxruntime/include"), // existing onnxruntime path
                .define("ESPEAK_NG_API", to: ""),
                .define("N_PATH_HOME", to: "1024"),
            ]
        ),
    ]
)

$(SRCROOT)/voicenotes/Espeak/libespeak-ng/include
$(SRCROOT)/voicenotes/espeak-ng/libespeak-ng/_repo/src/include
$(SRCROOT)/YourApp/onnxruntime/include     // your existing onnxruntime path