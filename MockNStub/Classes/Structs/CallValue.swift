public class CallValue {
    
    public let selector: Selector?
    public let function: String?
    public let value: Any?
    public let matcher: MatchingArguments
    
    public required init(selector: Selector, value: Any?, matcher: MatchingArguments) {
        self.selector = selector
        self.function = nil
        self.value = value
        self.matcher = matcher
    }
    
    public required init(function: String, value: Any?, matcher: MatchingArguments) {
        self.selector = nil
        self.function = function
        self.value = value
        self.matcher = matcher
    }
}

extension CallValue: CustomStringConvertible {
    public var description: String {
        var description = ""
        
        if let selector = selector {
            description.append("selector: ")
            description.append(String(describing: selector))
        }
        if let function = function {
            description.append("function: ")
            description.append(function)
        }
        
        description.append(" value: ")
        description.append(String(describing: value ?? "nil"))
        
        description.append(" matcher: ")
        description.append(String(describing: matcher))
        
        return description
    }
}
