public enum MethodID: Equatable {
    
    case name(String)
}

extension MethodID: CustomStringConvertible {
    
    public var description: String {
        var description = ""
        switch self {
        case .name(let name):
            description.append("function: ")
            description.append(name)
        }
        return description
    }
    
    public var rawString: String {
        switch self {
        case .name(let name):
            return name
        }
    }
}
