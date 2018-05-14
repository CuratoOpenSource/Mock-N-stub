public protocol CanMock: CanStub, HasCalls, HasVerifications, HasFailureHandler {}

public extension CanMock {

    func verify(inFile file: StaticString = #file, atLine line: UInt = #line) {
        for verification in verifications {
            if calls.filter({  $0.selector == verification.selector &&
                $0.function == verification.function }).filter({ verification.matcher.match(arguments: $0.arguments) }).count == 0 {
                
                failureHandler.fail(with: "Could not verify call to `\(methodName(from: verification))`", at: Location(file: file, line: line))
            }
        }
    }
    
    func expect(callTo selector: Selector, withArgumentsThatMatch matcher: CanMatchArguments = anyArgumentMatcher) {
        verifications.append(Verification(selector: selector, matcher: matcher))
    }
    
    func expect(callTo method: String, withArgumentsThatMatch matcher: CanMatchArguments = anyArgumentMatcher) {
        verifications.append(Verification(function: method, matcher: matcher))
    }
    
    func didCall(_ selector: Selector, with arguments: Any = ()) {
        calls.append(Call(selector: selector, arguments: arguments))
    }
    
    func didCall(_ function: String = #function, with arguments: Any = ()) {
        calls.append(Call(function: function, arguments: arguments))
    }
    
    func didCall<ReturnType>(_ selector: Selector, with arguments: Any = ()) -> ReturnType? {
        didCall(selector, with: arguments)
        return value(for: selector, with: arguments)
    }
    
    func didCall<ReturnType>(_ function: String = #function, with arguments: Any = ()) -> ReturnType? {
        didCall(function, with: arguments)
        return value(for: function, with: arguments)
    }
}

//MARK: Private Methods
private extension CanMock {
    
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
