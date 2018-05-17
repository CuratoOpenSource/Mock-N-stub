public protocol ProvidingFailureHandler {
    
    var failureHandler: FailingWithMessageAtLocation { get }
}

public extension ProvidingFailureHandler where Self: Mocking {
    
    var failureHandler: FailingWithMessageAtLocation {
        if let failureHandler: FailingWithMessageAtLocation = value() {
            return failureHandler
        } else {
            return XCTFailureHandler()
        }
    }
}
