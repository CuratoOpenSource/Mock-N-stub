public class CallValue {
    
    public let selector: Selector?
    public let function: String?
    public let value: Any?
    public let matcher: ArgumentMatcher
    
    public required init(selector: Selector, value: Any?, matcher: @escaping ArgumentMatcher) {
        self.selector = selector
        self.function = nil
        self.value = value
        self.matcher = matcher
    }
    
    public required init(function: String, value: Any?, matcher: @escaping ArgumentMatcher) {
        self.selector = nil
        self.function = function
        self.value = value
        self.matcher = matcher
    }
}
