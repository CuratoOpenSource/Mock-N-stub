// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "MockNStub",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(name: "MockNStub", targets: ["MockNStub"]),
        .library(name: "MockNStubNimbleMatchers", targets: ["MockNStubNimbleMatchers"]),
    ],
    dependencies: [
        .package(url: "https://github.com/CuratoOpenSource/ArrayPlusTuple", from: "2.1.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "8.0.2"),
    ],
    targets: [
        .target(
            name: "MockNStub",
            dependencies: [.byName(name: "ArrayPlusTuple")],
            path: "MockNStub"
        ),
        .target(
            name: "MockNStubNimbleMatchers",
            dependencies: [.byName(name: "MockNStub"), .byName(name: "Nimble")],
            path: "MockNStubNimbleMatchers"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
