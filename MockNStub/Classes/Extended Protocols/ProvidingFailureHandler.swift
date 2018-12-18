public protocol ProvidingFailureHandler {
    
    var failureHandler: FailingWithMessageAtLocation { get }
}

public extension ProvidingFailureHandler where Self: Mocking {
    
    var failureHandler: FailingWithMessageAtLocation {
        if let failureHandler: FailingWithMessageAtLocation = value(forMethodWithID: MethodID.name(#function), with: []) {
            return failureHandler
        } else {
            return XCTFailureHandler()
        }
    }
}
