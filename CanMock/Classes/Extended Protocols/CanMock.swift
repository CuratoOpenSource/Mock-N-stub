public protocol CanMock: CanStub, HasCallRegistry, HasVerifications, HasFailureHandler {
    
    func expect(callTo selector: Selector)
    func expect(callTo selector: Selector, withArgumentsThatMatch matcher: CanMatchArguments)
    
    func expect(callTo method: String)
    func expect(callTo method: String, withArgumentsThatMatch matcher: CanMatchArguments)
    
    
}

public extension CanMock {

    func verify(inFile file: StaticString = #file, atLine line: UInt = #line) {
        for verification in verifications {
            if callRegistry.calls.filter({  $0.selector == verification.selector &&
                $0.function == verification.function }).filter({ verification.matcher.match(arguments: $0.arguments) }).count == 0 {
                
                failureHandler.fail(with: "Could not verify call to `\(methodName(from: verification))`", at: Location(file: file, line: line))
            }
        }
    }
    
    func expect(callTo selector: Selector) {
        expect(callTo: selector, withArgumentsThatMatch: anyArgumentMatcher)
    }
    
    func expect(callTo method: String) {
        expect(callTo: method, withArgumentsThatMatch: anyArgumentMatcher)
    }
    
    func expect(callTo selector: Selector, withArgumentsThatMatch matcher: CanMatchArguments) {
        verifications.append(Verification(selector: selector, matcher: matcher))
    }
    
    func expect(callTo method: String, withArgumentsThatMatch matcher: CanMatchArguments) {
        verifications.append(Verification(function: method, matcher: matcher))
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
