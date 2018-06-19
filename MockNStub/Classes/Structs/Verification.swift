public struct Verification {
    
    let methodID: MethodID
    let matcher: MatchingArguments
}

extension Verification: CustomStringConvertible {
    
    public var description: String {
        var description = ""

        description.append(String(describing: methodID))
        description.append(" matcher: ")
        description.append(String(describing: matcher))
        
        return description
    }
}
