public protocol Stubbing: ProvidingMutableCallValues {}

public extension Stubbing {
    
    func given(_ selector: Selector, withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher, willReturn value: Any?) {
        callValues.append(CallValue(selector: selector, value: value, matcher: matcher))
    }
    
    func given(_ method: String, withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher, willReturn value: Any?) {
        callValues.append(CallValue(function: method, value: value, matcher: matcher))
    }
    
    func value<ReturnType>(for selector: Selector, with arguments: Any = ()) -> ReturnType? {
        guard let nonNilValue = callValues.filter({ $0.selector == selector }).filter({ $0.matcher.match(arguments: arguments) }).compactMap({ $0.value }).last else {
            if !isOptional(ReturnType.self) {
                logger.log("""
                    
                    
                    Got nil when asking for non optional type \(ReturnType.self)
                    there's probably a stub missing for selector `\(selector)` that's called with arguments `\(arguments)`
                    
                    current stubs:
                    \(dump(callValues))\n
                """, atLevel: .warning)
            }
            return nil
        }
        
        guard let valueOfExpectedType = nonNilValue as? ReturnType else {
            logger.log("Asking for value of type that's unkown to selector: `\(String(describing: selector))` \nExpected: \(type(of: nonNilValue)) Asked: \(ReturnType.self)", atLevel: .warning)
            return nil
        }
        
        return valueOfExpectedType
    }
    
    func value<ReturnType>(for method: String = #function, with arguments: Any = ()) -> ReturnType? {
        guard let nonNilValue = callValues.filter({ $0.function == method }).filter({ $0.matcher.match(arguments: arguments) }).compactMap({ $0.value }).last else {
            if !isOptional(ReturnType.self) {
                logger.log("""
                    
                    
                    Got nil when asking for non optional type \(ReturnType.self)
                    there's probably a stub missing for function: `\(method)` that's called with arguments `\(arguments)`
                    
                    current stubs:
                    \(dump(callValues))\n
                    """, atLevel: .warning)
            }
            return nil
        }
        
        guard let valueOfExpectedType = nonNilValue as? ReturnType else {
            logger.log("Asking for value of type that's unkown to function: `\(method)`\n Expected: \(type(of: nonNilValue)) Asked: \(ReturnType.self)", atLevel: .warning)
            return nil
        }
        
        return valueOfExpectedType
    }
}
