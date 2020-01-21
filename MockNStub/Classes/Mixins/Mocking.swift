import ArrayPlusTuple

public protocol Mocking: Stubbing, ProvidingMutableCalls, ProvidingMutableVerifications, ProvidingFailureHandler {}

//MARK: Public
public extension Mocking {

    typealias Fail = ()->()
    
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
        expect(.anyAmount, callsToFunction: function, withArgumentsThatMatch: matcher)
    }
    
    func expect(_ amount: Verification.Amount,
                callsToFunction function: String,
                withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher) {
        verifications.append(Verification(methodID: .name(function), matcher: matcher, amount: amount))
    }
    
    // MARK: Verification
    func verify(inFile file: StaticString = #file, atLine line: UInt = #line) {
        logger.logVerbose("calls\n\(calls)")
        
        findFails(forFile: file, andLine: line).forEach { (failure) in
            failure()
        }
    }
    
    func wouldFailIfVerified() -> Bool {
        return findFails().count > 0
    }
    
    func resetMock() {
        resetStub()
        calls = []
        verifications = []
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
    
    func expect(callToFunctionWithID functionID: FunctionID,
                withArgumentsThatMatch
        matcher: MatchingArguments = anyArgumentMatcher) {
        expect(.anyAmount, callsToFunctionWithID: functionID, withArgumentsThatMatch: matcher)
    }
    
    func expect(_ amount: Verification.Amount,
                callsToFunctionWithID functionID: FunctionID,
                withArgumentsThatMatch matcher: MatchingArguments = anyArgumentMatcher) {
        expect(amount, callsToFunction: functionID.rawValue, withArgumentsThatMatch: matcher)
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
        }
    }
    
    func failureMessage(for failedVerification: Verification) -> String {
        return failureMessagePrefix(for: failedVerification)
                + " `\(methodName(from: failedVerification))`"
                + verificationFailureMessageExplaination(for: failedVerification)
    }
    
    func failureMessagePrefix(for failedVerification: Verification) -> String {
        switch failedVerification.amount {
        case .anyAmount:
            return "Could not verify call to"
        case .exactly(let amount):
            return "Could not verify \(amount) calls to"
        }
    }
    
    func verificationFailureMessageExplaination(for FailedVerification: Verification) -> String {
        if calls.count == 0 {
            return ". No other calls have been made."
        } else {
            return """
            
             however, the following calls have been registered:
            \(pretify(calls: calls))
            """
        }
    }
    
    func pretify(calls: [Call]) -> String {
        return calls.map{ "-\($0.methodID.rawString)\n" }.joined()
    }
    
    
    func calls(matchingVerification verification: Verification) -> [Call] {
        calls
            .filter({   $0.methodID == verification.methodID })
            .filter({ verification.matcher.match(arguments: $0.arguments) })
    }
    
    func failingVerifications() -> [Verification] {
        verifications
            .filter { verification in
                switch verification.amount {
                    
                case .anyAmount:
                    if calls(matchingVerification: verification).count == 0 {
                        return true
                    }
                case .exactly(let amount):
                    
                    if calls(matchingVerification: verification).count == 0 && amount != 0 {
                        return true
                    } else if calls(matchingVerification: verification).count != amount {
                        return true
                    }
                }
                
                return false
            }
    }
    
    func findFails(forFile file: StaticString = #file, andLine line: UInt = #line) -> [Fail] {
        failingVerifications()
            .map { (verification) in
                { self.failureHandler.fail(with: self.failureMessage(for: verification),
                                           at: Location(file: file, line: line)) }
            }
    }
}
