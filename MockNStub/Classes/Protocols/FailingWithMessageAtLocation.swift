public protocol FailingWithMessageAtLocation {
    
    func fail(with message: String, at location: Location)
}
