public enum MethodID: Equatable {
    
    case selector(Selector)
    case name(String)
}

extension MethodID: CustomStringConvertible {
    
    public var description: String {
        var description = ""
        switch self {
        case .name(let name):
            description.append("function: ")
            description.append(name)
        case .selector(let selector):
            description.append("selector: ")
            description.append(String(describing: selector))
        }
        return description
    }
}
