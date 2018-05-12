public protocol HasFailureHandler {
    
    var failureHandler: CanFailWithMessageAtLocation { get }
}

public extension HasFailureHandler where Self: CanMock {
    
    var failureHandler: CanFailWithMessageAtLocation {
        return value(for: #function, with: ()) as? CanFailWithMessageAtLocation ?? XCTFailureHandler()
    }
}
