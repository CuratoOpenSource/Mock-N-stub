import XCTest

public struct XCTFailureHandler: CanFailWithMessageAtLocation {
    
    public func fail(with message: String, at location: Location) {
        XCTFail(message, file: location.file, line: location.line)
    }
    
    public init() {}
}
