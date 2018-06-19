public protocol Stubbing: ProvidingMutableCallValues {}

//MARK: Public
public extension Stubbing {
    
    // MARK: Selectors
    func didCallSelector<ReturnType>(_ selector: Selector, withArguments arguments: Any?...) -> ReturnType? {
        return value(forMethodWithID: .selector(selector), with: arguments)
    }
    
    func given(_ selector: Selector, withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher, willReturn value: Any?) {
        callValues.append(CallValue(methodID: .selector(selector), value: value, matcher: matcher))
    }
    
    func valueForSelector<ReturnType>(_ selector: Selector) -> ReturnType? {
        return value(forMethodWithID: .selector(selector), with: [])
    }
    
    // MARK: Functions
    func didCallFunction<ReturnType>(_ function: String = #function, withArguments arguments: Any?...) -> ReturnType? {
        return value(forMethodWithID: .name(function), with: arguments)
    }
    
    func given(_ function: String, withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher, willReturn value: Any?) {
        callValues.append(CallValue(methodID: .name(function), value: value, matcher: matcher))
    }
    
    func valueForFunction<ReturnType>(_ function: String = #function) -> ReturnType? {
        return value(forMethodWithID: .name(function), with: [])
    }
}

//MARK: Internal
internal extension Stubbing {
    
    func value<ReturnType>(forMethodWithID methodID: MethodID, with arguments: [Any?]) -> ReturnType? {
        let tupleArguments = arguments.tuple
        let callValuesMatchingMethodId = callValues.filter { $0.methodID == methodID }
        let callValuesMatchingMethodIdAndArguments = callValuesMatchingMethodId.filter{ $0.matcher.match(arguments: tupleArguments) }
        
        guard let nonNilValue = callValuesMatchingMethodIdAndArguments.last?.value else {
            if !isOptional(ReturnType.self) {
                logger.log("""
                    
                    
                    Got nil when asking for non optional type \(ReturnType.self)
                    there' might be a stub missing for \(methodID) that's called with arguments `\(tupleArguments)`
                    
                    stubs for \(methodID):
                    \(dump(callValuesMatchingMethodId))\n
                    
                    all stubs:
                    
                    \(dump(callValues))\n
                    
                    """, atLevel: .warning)
            }
            return nil
        }
        
        guard let valueOfExpectedType = nonNilValue as? ReturnType else {
            logger.logWarning("Asking for value of type that's unkown to \(methodID) \n Asked: \(ReturnType.self) got: \(type(of: nonNilValue))")
            return nil
        }
        
        return valueOfExpectedType
    }
}
