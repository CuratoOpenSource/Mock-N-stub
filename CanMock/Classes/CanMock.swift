import XCTest

public protocol CanMock: HasCalls, HasVerifications {
    
    func didCall(_ selector: Selector)
    func didCall(_ selector: Selector, with arguments: Any)
    
    func expect(callTo selector: Selector)
    func expect(callTo selector: Selector, thatMatches matcher: @escaping ArgumentMatcher)
    
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
        expect(callTo: selector, thatMatches: anyArgumentMatcher )
    }
    
    func expect(callTo selector: Selector, thatMatches matcher: @escaping ArgumentMatcher) {
        verifications.append(Verification(selector: selector, matcher: matcher))
    }
    
    func verify(at location: Location) {
        for verification in verifications {
            if calls.filter({ $0.selector == verification.selector }).filter({ verification.matcher($0.arguments) }).count == 0 {
                XCTFail("Could not verify call to \(verification.selector)", file: location.file, line: location.line)
            }
        }
    }
}

public protocol HasCalls: class {
    
    var calls: [Call] { get set }
}

public protocol HasVerifications: class {
    
    var verifications: [Verification] { get set }
}

public struct Call {
    
    let selector: Selector
    let arguments: Any
    
    init(selector: Selector, arguments: Any) {
        self.selector = selector
        self.arguments = arguments
    }
}

public typealias ArgumentMatcher = (Any)->(Bool)

let anyArgumentMatcher: ArgumentMatcher = { _ in return true }

public struct Verification {
    
    let selector: Selector
    let matcher: ArgumentMatcher
    
    init(selector: Selector, matcher: @escaping ArgumentMatcher) {
        self.selector = selector
        self.matcher = matcher
    }
}

public struct Location {
    public let file: StaticString
    public let line: UInt
    
    public init(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }
}

public func verify(_ mock: CanMock, inFile file: StaticString = #file, atLine line: UInt = #line) {
    mock.verify(at: Location(file: file, line: line))
}
