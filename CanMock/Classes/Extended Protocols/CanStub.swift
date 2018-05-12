public protocol CanStub: HasCallValues {
    
    func given(_ selector: Selector, willReturn value: Any?)
    func given(_ selector: Selector, withArgumentsThatMatch matcher: CanMatchArguments, willReturn value: Any?)
    
    func given(_ method: String, willReturn value: Any?)
    func given(_ method: String, withArgumentsThatMatch matcher: CanMatchArguments, willReturn value: Any?)
    
    func value(for selector: Selector, with arguments: Any) -> Any?
    func value(for method: String, with arguments: Any) -> Any?
}

public extension CanStub {
    
    func given(_ selector: Selector, willReturn value: Any?) {
        given(selector, withArgumentsThatMatch: anyArgumentMatcher, willReturn: value)
    }
    
    func given(_ method: String, willReturn value: Any?) {
        given(method, withArgumentsThatMatch: anyArgumentMatcher, willReturn: value)
    }
    
    func given(_ selector: Selector, withArgumentsThatMatch matcher: CanMatchArguments, willReturn value: Any?) {
        callValues.append(CallValue(selector: selector, value: value, matcher: matcher))
    }
    
    func given(_ method: String, withArgumentsThatMatch matcher: CanMatchArguments, willReturn value: Any?) {
        callValues.append(CallValue(function: method, value: value, matcher: matcher))
    }
    
    func value(for selector: Selector, with arguments: Any) -> Any? {
        return callValues.filter({ $0.selector == selector }).filter({ $0.matcher.match(arguments: arguments) }).compactMap({ $0.value }).first
    }
    
    func value(for method: String, with arguments: Any) -> Any? {
        return callValues.filter({ $0.function == method }).filter({ $0.matcher.match(arguments: arguments) }).compactMap({ $0.value }).first
    }
}
