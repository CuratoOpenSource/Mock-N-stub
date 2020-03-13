//
//  Copyright © 2019 Curato Research BV. All rights reserved.
//  

import Nimble
import MockNStub


//MARK: - Public

//MARK: Without argument matching

public func beCalledOnce<T: Mocking & DefiningFunctionID>(at functionID: T.FunctionID) -> Predicate<T> {
    beCalled(.exactly(amount: 1), timesAt: functionID, withArgumentsThatMatch: matcherThatAlwaysPasses)
}

public func beCalled<T: Mocking & DefiningFunctionID>(at functionID: T.FunctionID) -> Predicate<T> {
    beCalled(.anyAmount, timesAt: functionID, withArgumentsThatMatch: matcherThatAlwaysPasses)
}

public func beCalled<T: Mocking & DefiningFunctionID>(_ amount: Verification.Amount,
                                                      timesAt functionID: T.FunctionID) -> Predicate<T> {
    beCalled(amount, timesAt: functionID, withArgumentsThatMatch: matcherThatAlwaysPasses)
}

//MARK: With argument matching

public func beCalledOnce<T: Mocking & DefiningFunctionID, ARGS>(at functionID: T.FunctionID,
                                                                withArgumentsThatMatch matcher: @escaping (ARGS)->Bool) -> Predicate<T> {
    beCalled(.exactly(amount: 1), timesAt: functionID, withArgumentsThatMatch: matcher)
}

public func beCalled<T: Mocking & DefiningFunctionID, ARGS>(at functionID: T.FunctionID,
                                                            withArgumentsThatMatch matcher: @escaping (ARGS)->Bool) -> Predicate<T> {
    beCalled(.anyAmount, timesAt: functionID, withArgumentsThatMatch: matcher)
}

public func beCalled<T: Mocking & DefiningFunctionID, ARGS>(_ amount: Verification.Amount,
                                                            timesAt functionID: T.FunctionID,
                                                            withArgumentsThatMatch matcher: ((ARGS)->Bool)?) -> Predicate<T> {
    
    Predicate { (actualExpression: Expression<T>) throws -> PredicateResult in
        let expectationMessage = "be called \(amount) times at \(functionID.rawValue)\(matcher != nil ? " based on passed argumentMatcher" : "")"
        
        if let mock = try actualExpression.evaluate() {
            
            if let matcher = matcher {
                mock.expect(amount, callsToFunctionWithID: functionID, withArgumentsThatMatch: ArgumentMatcher(matcher: matcher))
            } else {
                mock.expect(amount, callsToFunctionWithID: functionID)
            }
            
            return PredicateResult(
                bool: mock.wouldFailIfVerified() == false,
                message: ExpectationMessage.expectedTo(expectationMessage + "\n" + mock.applicableFailureMessages().joined(separator: "\n"))
            )
        } else {
            return PredicateResult(
                status: .fail,
                message: ExpectationMessage.expectedTo(expectationMessage).appendedBeNilHint()
            )
        }
    }
}

//MARK: With argument matching expectations

public func beCalled<T: Mocking & DefiningFunctionID, ARGS>(_ amount: Verification.Amount,
                                                            timesAt functionID: T.FunctionID,
                                                            matchingExpectations expectations: @escaping ((ARGS)->Void)) -> Predicate<T> {
    beCalled(amount, timesAt: functionID, withArgumentsThatMatch: returningTrue(expectations))
}

//MARK: - Private

private let matcherThatAlwaysPasses = { (args: Any?) -> Bool in
    return true
}
