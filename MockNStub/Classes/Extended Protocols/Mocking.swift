import ArrayPlusTuple

public protocol Mocking: Stubbing, ProvidingMutableCalls, ProvidingMutableVerifications, ProvidingFailureHandler {}

//MARK: Public
public extension Mocking {
    
    // MARK: Selectors
    func didCallSelector(_ selector: Selector) {
        didCallSelector(selector, withArguments: [])
    }
    
    func didCallSelector(_ selector: Selector, withArguments arguments: Any?...) {
        registerCall(to: .selector(selector), withArguments: arguments)
    }
    
    func didCallSelector<ReturnType: ProvidingDefaultStubValue>(_ selector: Selector) -> ReturnType {
        return didCallSelector(selector, withArguments: [])
    }
    
    func didCallSelector<ReturnType>(_ selector: Selector) -> ReturnType? {
        return didCallSelector(selector, withArguments: [])
    }
    
    func didCallSelector<ReturnType: ProvidingDefaultStubValue> (_ selector: Selector, withArguments arguments: Any?...) -> ReturnType {
        registerCall(to: .selector(selector), withArguments: arguments)
        return value(forMethodWithID: .selector(selector), with: arguments)
    }
    
    func didCallSelector<ReturnType>(_ selector: Selector, withArguments arguments: Any?...) -> ReturnType? {
        registerCall(to: .selector(selector), withArguments: arguments)
        return value(forMethodWithID: .selector(selector), with: arguments)
    }
    
    func expect(callToSelector selector: Selector, withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher) {
        verifications.append(Verification(methodID: .selector(selector), matcher: matcher))
    }
    
    // MARK: Functions
    func didCallFunction(_ function: String = #function) {
        didCallFunction(function, withArguments: [])
    }
    
    func didCallFunction(_ function: String = #function, withArguments arguments: Any?...) {
        registerCall(to: .name(function), withArguments: arguments)
    }
    
    func didCallFunction<ReturnType: ProvidingDefaultStubValue>(_ function: String = #function) -> ReturnType {
        return didCallFunction(function, withArguments: [])
    }
    
    func didCallFunction<ReturnType>(_ function: String = #function) -> ReturnType? {
        return didCallFunction(function, withArguments: [])
    }
    
    func didCallFunction<ReturnType: ProvidingDefaultStubValue>(_ function: String = #function, withArguments arguments: Any?...) -> ReturnType {
        registerCall(to: .name(function), withArguments: arguments)
        return value(forMethodWithID: .name(function), with: arguments)
    }
    
    func didCallFunction<ReturnType>(_ function: String = #function, withArguments arguments: Any?...) -> ReturnType? {
        registerCall(to: .name(function), withArguments: arguments)
        return value(forMethodWithID: .name(function), with: arguments)
    }
    
    func expect(callToFunction function: String, withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher) {
        verifications.append(Verification(methodID: .name(function), matcher: matcher))
    }
    
    // MARK: Verification
    func verify(inFile file: StaticString = #file, atLine line: UInt = #line) {
        for verification in verifications {
            if calls.filter({   $0.methodID == verification.methodID }).filter({ verification.matcher.match(arguments: $0.arguments) }).count == 0 {
                failureHandler.fail(with: "Could not verify call to `\(methodName(from: verification))`", at: Location(file: file, line: line))
            }
        }
    }
}

//MARK: DefiningFunctionID
public extension Mocking where Self: DefiningFunctionID {
    
    func didCallFunction(withID functionID: FunctionID) {
        didCallFunction(functionID.rawValue, withArguments: [])
    }
    
    func didCallFunction(withID functionID: FunctionID, withArguments arguments: Any?...) {
        registerCall(to: .name(functionID.rawValue), withArguments: arguments)
    }
    
    func didCallFunction<ReturnType: ProvidingDefaultStubValue>(withID functionID: FunctionID) -> ReturnType {
        return didCallFunction(functionID.rawValue, withArguments: [])
    }
    
    func didCallFunction<ReturnType>(withID functionID: FunctionID) -> ReturnType? {
        return didCallFunction(functionID.rawValue, withArguments: [])
    }
    
    func didCallFunction<ReturnType: ProvidingDefaultStubValue>(withID functionID: FunctionID, withArguments arguments: Any?...) -> ReturnType {
        registerCall(to: .name(functionID.rawValue), withArguments: arguments)
        return value(forMethodWithID: .name(functionID.rawValue), with: arguments)
    }
    
    func didCallFunction<ReturnType>(withID functionID: FunctionID, withArguments arguments: Any?...) -> ReturnType? {
        registerCall(to: .name(functionID.rawValue), withArguments: arguments)
        return value(forMethodWithID: .name(functionID.rawValue), with: arguments)
    }
    
    func expect(callToFunctionWithID functionID: FunctionID, withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher) {
        verifications.append(Verification(methodID: .name(functionID.rawValue), matcher: matcher))
    }
}

//MARK: Private
private extension Mocking {
    
    func registerCall(to methodID: MethodID, withArguments arguments: [Any?]) {
        calls.append(Call(methodID: methodID, arguments: arguments.tuple))
    }
    
    func methodName(from verification: Verification) -> String {
        switch verification.methodID {
        case .name(let name):
            return name
        case .selector(let selector):
            return "\(selector)"
        }
    }
}
