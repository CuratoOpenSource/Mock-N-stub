public protocol CanStub: HasSelectorValues {
    
    func given(_ selector: Selector, willReturn: Any?)
    func given(_ selector: Selector, withArgumentsThatMatch matcher: @escaping ArgumentMatcher, willReturn: Any?)
    
    func value(for selector: Selector, with arguments: Any) -> Any?
}

public extension CanStub {
    
    func given(_ selector: Selector, willReturn value: Any?) {
        given(selector, withArgumentsThatMatch: anyArgumentMatcher, willReturn: value)
    }
    
    func given(_ selector: Selector, withArgumentsThatMatch matcher: @escaping ArgumentMatcher, willReturn value: Any?) {
        selectorValues.append(SelectorValue(selector: selector, value: value, matcher: matcher))
    }
    
    func value(for selector: Selector, with arguments: Any) -> Any? {
        return selectorValues.filter({ $0.selector == selector }).filter({ $0.matcher(arguments) }).compactMap({ $0.value }).first
    }
}
