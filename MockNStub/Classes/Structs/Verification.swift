public class Verification {
    
    let selector: Selector?
    let function: String?
    let matcher: MatchingArguments
    
    public required init(selector: Selector, matcher: MatchingArguments) {
        self.selector = selector
        self.function = nil
        self.matcher = matcher
    }
    
    public required init(function: String, matcher: MatchingArguments) {
        self.selector = nil
        self.function = function
        self.matcher = matcher
    }
}

extension Verification: CustomStringConvertible {
    
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
        
        description.append(" matcher: ")
        description.append(String(describing: matcher))
        
        return description
    }
}
