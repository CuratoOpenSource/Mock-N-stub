public struct Verification {
    
    let selector: Selector
    let matcher: ArgumentMatcher
    
    init(selector: Selector, matcher: @escaping ArgumentMatcher) {
        self.selector = selector
        self.matcher = matcher
    }
}
