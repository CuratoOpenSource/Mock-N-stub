import XCTest

public protocol CanMock: CanStub, HasCalls, HasVerifications {
    
    func didCall(_ selector: Selector)
    func didCall(_ selector: Selector, with arguments: Any)
    
    func expect(callTo selector: Selector)
    func expect(callTo selector: Selector, withArgumentsThatMatch matcher: @escaping ArgumentMatcher)
    
    func verify(at location: Location)
}

public extension CanMock {

    func didCall(_ selector: Selector) {
        didCall(selector, with:())
    }
    
    func didCall(_ selector: Selector, with arguments: Any) {
        calls.append(Call(selector: selector, arguments: arguments))
    }
    
    func expect(callTo selector: Selector) {
        expect(callTo: selector, withArgumentsThatMatch: anyArgumentMatcher )
    }
    
    func expect(callTo selector: Selector, withArgumentsThatMatch matcher: @escaping ArgumentMatcher) {
        verifications.append(Verification(selector: selector, matcher: matcher))
    }
    
    func verify(at location: Location) {
        for verification in verifications {
            if calls.filter({ $0.selector == verification.selector }).filter({ verification.matcher($0.arguments) }).count == 0 {
                XCTFail("Could not verify call to `\(verification.selector)`", file: location.file, line: location.line)
            }
        }
    }
}
