public struct Call {
    
    public let methodID: MethodID
    public let arguments: Any
}

extension Call: CustomStringConvertible {
    public var description: String {
        var description = ""
        
        description.append(String(describing: methodID))
        description.append(" arguments: ")
        description.append(String(describing: arguments))
        
        return description
    }
}
