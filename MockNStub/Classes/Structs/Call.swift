public class Call {
    
    let selector: Selector?
    let function: String?
    let arguments: Any
    
    public required init(selector: Selector, arguments: Any) {
        self.selector = selector
        self.function = nil
        self.arguments = arguments
    }
    
    public required init(function: String, arguments: Any) {
        self.selector = nil
        self.function = function
        self.arguments = arguments
    }
}

extension Call: CustomStringConvertible {
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
        
        description.append(" arguments: ")
        description.append(String(describing: arguments))
        
        return description
    }
}
