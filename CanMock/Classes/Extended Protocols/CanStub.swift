public protocol CanStub: HasCallValues {
    
}

public extension CanStub {
    
    func given(_ selector: Selector, withArgumentsThatMatch matcher: CanMatchArguments = anyArgumentMatcher, willReturn value: Any?) {
        callValues.append(CallValue(selector: selector, value: value, matcher: matcher))
    }
    
    func given(_ method: String, withArgumentsThatMatch matcher: CanMatchArguments = anyArgumentMatcher, willReturn value: Any?) {
        callValues.append(CallValue(function: method, value: value, matcher: matcher))
    }
    
    func value<ReturnType>(for selector: Selector, with arguments: Any = ()) -> ReturnType? {
        return callValues.filter({ $0.selector == selector }).filter({ $0.matcher.match(arguments: arguments) }).compactMap({ $0.value }).last as? ReturnType
    }
    
    func value<ReturnType>(for method: String = #function, with arguments: Any = ()) -> ReturnType? {
        return callValues.filter({ $0.function == method }).filter({ $0.matcher.match(arguments: arguments) }).compactMap({ $0.value }).last as? ReturnType
    }
}
