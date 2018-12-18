public protocol Stubbing: ProvidingMutableCallValues {}

//MARK: Public
public extension Stubbing {
    
    // MARK: Functions
    func didCallFunction<ReturnType: ProvidingDefaultStubValue>(_ function: String = #function, withArguments arguments: Any?...) -> ReturnType {
        return value(forMethodWithID: .name(function), with: arguments)
    }
    
    func didCallFunction<ReturnType>(_ function: String = #function, withArguments arguments: Any?...) -> ReturnType? {
        return value(forMethodWithID: .name(function), with: arguments)
    }
    
    func given(_ function: String, withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher, willReturn value: Any?) {
        callValues.append(CallValue(methodID: .name(function), value: value, matcher: matcher))
    }
}

//MARK: DefiningFunctionID
public extension Stubbing where Self: DefiningFunctionID {
    
    func didCallFunction<ReturnType: ProvidingDefaultStubValue>(withID functionID: FunctionID, withArguments arguments: Any?...) -> ReturnType {
        return value(forMethodWithID: .name(functionID.rawValue), with: arguments)
    }
    
    func didCallFunction<ReturnType>(withID functionID: FunctionID, withArguments arguments: Any?...) -> ReturnType? {
        return value(forMethodWithID: .name(functionID.rawValue), with: arguments)
    }
    
    func given(callToFunctionWithID functionID: FunctionID, withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher, willReturn value: Any?) {
        callValues.append(CallValue(methodID: .name(functionID.rawValue), value: value, matcher: matcher))
    }
}

//MARK: Internal
internal extension Stubbing {
    
    func value<ReturnType: ProvidingDefaultStubValue>(forMethodWithID methodID: MethodID, with arguments: [Any?]) -> ReturnType {
        return value(forMethodWithID: methodID, with: arguments, shouldWarnAboutNilValue: false) ?? .defaultStubValue()
    }
    
    func value<ReturnType>(forMethodWithID methodID: MethodID, with arguments: [Any?], shouldWarnAboutNilValue: Bool = true) -> ReturnType? {
        logger.logVerbose("\(methodID), \(arguments)")
        
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
