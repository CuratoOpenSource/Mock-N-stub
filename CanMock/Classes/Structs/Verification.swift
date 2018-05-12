public class Verification {
    
    let selector: Selector?
    let function: String?
    let matcher: ArgumentMatcher
    
    public required init(selector: Selector, matcher: @escaping ArgumentMatcher) {
        self.selector = selector
        self.function = nil
        self.matcher = matcher
    }
    
    public required init(function: String, matcher: @escaping ArgumentMatcher) {
        self.selector = nil
        self.function = function
        self.matcher = matcher
    }
}
