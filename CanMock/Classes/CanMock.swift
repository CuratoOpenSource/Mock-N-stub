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

/// Matches any argument
func anyArgumentMatcher( arguments: Any) -> Bool { return true }

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

//MARK: - CanStub
public protocol CanStub: HasSelectorValues {
    
    func given(_ selector: Selector, willReturn: Any?)
    func given(_ selector: Selector, withArgumentsThatMatch matcher: @escaping ArgumentMatcher, willReturn: Any?)
    func value(for selector: Selector, with arguments: Any) -> Any?
}

public extension CanStub {
    
    func given(_ selector: Selector, willReturn value: Any?) {
        given(selector, withArgumentsThatMatch: anyArgumentMatcher, willReturn: value)
    }
    
    func given(_ selector: Selector, withArgumentsThatMatch matcher: @escaping ArgumentMatcher, willReturn value: Any?) {
        selectorValues.append(SelectorValue(selector: selector, value: value, matcher: matcher))
    }
    
    func value(for selector: Selector, with arguments: Any) -> Any? {
        return selectorValues.filter({ $0.selector == selector }).filter({ $0.matcher(arguments) }).compactMap({ $0.value }).first
    }
}

public protocol HasSelectorValues: class {
    
    var selectorValues: [SelectorValue] { get set }
}

public struct SelectorValue {
    
    public let selector: Selector
    public let value: Any?
    public let matcher: ArgumentMatcher
    
    public init(selector: Selector, value: Any?, matcher: @escaping ArgumentMatcher) {
        self.selector = selector
        self.value = value
        self.matcher = matcher
    }
}
