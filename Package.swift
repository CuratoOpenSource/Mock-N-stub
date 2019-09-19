// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "MockNStub",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(name: "MockNStub", targets: ["MockNStub"])
    ],
    dependencies: [
        .package(url: "https://github.com/lvnkmn/ArrayPlusTuple", from: "2.1.0"),
    ],
    targets: [
        .target(
            name: "MockNStub",
            dependencies: [.byName(name: "ArrayPlusTuple")],
            path: "MockNStub"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
