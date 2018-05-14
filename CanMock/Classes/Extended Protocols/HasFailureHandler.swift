public protocol HasFailureHandler {
    
    var failureHandler: CanFailWithMessageAtLocation { get }
}

public extension HasFailureHandler where Self: CanMock {
    
    var failureHandler: CanFailWithMessageAtLocation {
        if let failureHandler: CanFailWithMessageAtLocation = value() {
            return failureHandler
        } else {
            return XCTFailureHandler()
        }
    }
}
