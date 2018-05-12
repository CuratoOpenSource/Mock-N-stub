public protocol CanMock: CanStub, HasCallRegistry, HasVerifications, HasFailureHandler {
    
    func expect(callTo selector: Selector)
    func expect(callTo selector: Selector, withArgumentsThatMatch matcher: @escaping ArgumentMatcher)
    
    func expect(callTo method: String)
    func expect(callTo method: String, withArgumentsThatMatch matcher: @escaping ArgumentMatcher)
    
    func verify(at location: Location)
}

public extension CanMock {

    func expect(callTo selector: Selector) {
        expect(callTo: selector, withArgumentsThatMatch: anyArgumentMatcher )
    }
    
    func expect(callTo method: String) {
        expect(callTo: method, withArgumentsThatMatch: anyArgumentMatcher)
    }
    
    func expect(callTo selector: Selector, withArgumentsThatMatch matcher: @escaping ArgumentMatcher) {
        verifications.append(Verification(selector: selector, matcher: matcher))
    }
    
    func expect(callTo method: String, withArgumentsThatMatch matcher: @escaping ArgumentMatcher) {
        verifications.append(Verification(function: method, matcher: matcher))
    }
    
    func verify(at location: Location) {
        for verification in verifications {
            if callRegistry.calls.filter({  $0.selector == verification.selector &&
                                            $0.function == verification.function }).filter({ verification.matcher($0.arguments) }).count == 0 {

                failureHandler.fail(with: "Could not verify call to `\(methodName(from: verification))`", at: location)
            }
        }
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
