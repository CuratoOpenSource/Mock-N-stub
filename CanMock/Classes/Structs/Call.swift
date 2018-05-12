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
