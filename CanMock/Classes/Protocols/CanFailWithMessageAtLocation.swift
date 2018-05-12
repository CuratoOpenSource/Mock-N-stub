public protocol CanFailWithMessageAtLocation {
    
    func fail(with message: String, at location: Location)
}
