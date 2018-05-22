public protocol Stubbing: ProvidingMutableCallValues {}

//MARK: Public
public extension Stubbing {
    
    // MARK: Selectors
    func didCallSelector<ReturnType>(_ selector: Selector, withArguments arguments: Any?...) -> ReturnType? {
        return valueForSelector(selector, with: arguments.tuple)
    }
    
    func given(_ selector: Selector, withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher, willReturn value: Any?) {
        callValues.append(CallValue(selector: selector, value: value, matcher: matcher))
    }
    
    func valueForSelector<ReturnType>(_ selector: Selector) -> ReturnType? {
        return valueForSelector(selector, with: [])
    }
    
    // MARK: Functions
    func didCallFunction<ReturnType>(_ function: String = #function, withArguments arguments: Any?...) -> ReturnType? {
        return valueForFunction(function, with: arguments.tuple)
    }
    
    func given(_ function: String, withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher, willReturn value: Any?) {
        callValues.append(CallValue(function: function, value: value, matcher: matcher))
    }
    
    func valueForFunction<ReturnType>(_ function: String = #function) -> ReturnType? {
        return valueForFunction(function, with: [])
    }
}

//MARK: Internal
internal extension Stubbing {
    
    // MARK: Selectors
    func valueForSelector<ReturnType>(_ selector: Selector, with arguments: Any) -> ReturnType? {
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
    
    // MARK: Functions
    func valueForFunction<ReturnType>(_ function: String = #function, with arguments: Any) -> ReturnType? {
        guard let nonNilValue = callValues.filter({ $0.function == function }).filter({ $0.matcher.match(arguments: arguments) }).compactMap({ $0.value }).last else {
            if !isOptional(ReturnType.self) {
                logger.log("""
                    
                    
                    Got nil when asking for non optional type \(ReturnType.self)
                    there's probably a stub missing for function: `\(function)` that's called with arguments `\(arguments)`
                    
                    current stubs:
                    \(dump(callValues))\n
                    """, atLevel: .warning)
            }
            return nil
        }
        
        guard let valueOfExpectedType = nonNilValue as? ReturnType else {
            logger.log("Asking for value of type that's unkown to function: `\(function)`\n Expected: \(type(of: nonNilValue)) Asked: \(ReturnType.self)", atLevel: .warning)
            return nil
        }
        
        return valueOfExpectedType
    }
}
