public protocol Mocking: Stubbing, ProvidingMutableCalls, ProvidingMutableVerifications, ProvidingFailureHandler {}

//MARK: Pubblic
public extension Mocking {
    
    // MARK: Selectors
    func didCallSelector(_ selector: Selector) {
        didCallSelector(selector, withArguments: [])
    }
    
    func didCallSelector(_ selector: Selector, withArguments arguments: Any?...) {
        registerCall(to: selector, withArguments: arguments)
    }
    
    func didCallSelector<ReturnType>(_ selector: Selector) -> ReturnType? {
        return didCallSelector(selector, withArguments: [])
    }
    
    func didCallSelector<ReturnType>(_ selector: Selector, withArguments arguments: Any?...) -> ReturnType? {
        registerCall(to: selector, withArguments: arguments)
        return valueForSelector(selector, with: arguments.tuple)
    }
    
    func expect(callToSelector selector: Selector, withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher) {
        verifications.append(Verification(selector: selector, matcher: matcher))
    }
    
    // MARK: Functions
    func didCallFunction(_ function: String = #function) {
        didCallFunction(withArguments: [])
    }
    
    func didCallFunction(_ function: String = #function, withArguments arguments: Any?...) {
        registerCall(to: function, withArguments: arguments)
    }
    
    func didCallFunction<ReturnType>(_ function: String = #function) -> ReturnType? {
        return didCallFunction(function, withArguments: [])
    }
    
    func didCallFunction<ReturnType>(_ function: String = #function, withArguments arguments: Any?...) -> ReturnType? {
        registerCall(to: function, withArguments: arguments)
        return valueForFunction(function, with: arguments.tuple)
    }
    
    func expect(callToFunction function: String, withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher) {
        verifications.append(Verification(function: function, matcher: matcher))
    }
    
    // MARK: Verification
    func verify(inFile file: StaticString = #file, atLine line: UInt = #line) {
        for verification in verifications {
            if calls.filter({   $0.selector == verification.selector &&
                                $0.function == verification.function }).filter({ verification.matcher.match(arguments: $0.arguments) }).count == 0 {
                
                failureHandler.fail(with: "Could not verify call to `\(methodName(from: verification))`", at: Location(file: file, line: line))
            }
        }
    }
}

//MARK: Private
private extension Mocking {
    
    func registerCall(to function: String, withArguments arguments: [Any?]) {
        calls.append(Call(function: function, arguments: arguments.tuple))
    }
    
    func registerCall(to selector: Selector, withArguments arguments: [Any?]) {
        calls.append(Call(selector: selector, arguments: arguments.tuple))
    }
    
    func methodName(from verification: Verification) -> String {
        if let selector = verification.selector {
            return "\(selector)"
        } else if let function = verification.function {
            return function
        } else {
            return ""
        }
    }
}
