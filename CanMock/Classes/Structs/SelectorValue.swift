public struct SelectorValue {
    
    public let selector: Selector
    public let value: Any?
    public let matcher: ArgumentMatcher
    
    public init(selector: Selector, value: Any?, matcher: @escaping ArgumentMatcher) {
        self.selector = selector
        self.value = value
        self.matcher = matcher
    }
}
