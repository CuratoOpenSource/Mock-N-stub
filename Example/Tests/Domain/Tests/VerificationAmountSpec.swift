import XCTest
import Quick
import Nimble
import MockNStub

class VerificationAmountSpec: QuickSpec {
    
    override func spec() {
        
        var sut: MockWithFunctionIDs!
        
        
        let givenAMock = Given(a: MockWithFunctionIDs.self, {
            
            sut = MockWithFunctionIDs()
            
        })
        
        givenAMock.when("expecting zero calls to doThis") {
            sut.expect(.exactly(amount: 0), callsToFunctionWithID: .doThis)
            
            }.andWhen("zero calls have been made to doIt", {})
            .then("it shouldn't fail when verifying") {
                sut.verify()
        }
        
        givenAMock.when("expecting zero calls to doThat with true arg") {
            sut.expect(.exactly(amount: 0), callsToFunctionWithID: .doThatWithBooleanArgument,
                       withArgumentsThatMatch: ArgumentMatcher(matcher: { (boolArg: Bool) -> Bool in
                return boolArg == true
            }))
            
            }.when("a call is made to doThat with false arg") {
                sut.doThat(with: false)
            }.then("it should fail when verifying") {
                sut.verify()
        }
        
        (1...3).forEach { (callCount) in
            
            let mockWithVariableAmountOfMethodCalls = givenAMock.when("a method is called \(callCount) times", {
                
                (0..<callCount).forEach({ (_) in
                    sut.didCallFunction(withID: .doThis)
                })
            })
            
            mockWithVariableAmountOfMethodCalls.andWhen("\(callCount) of calls are expected", {
                
                sut.expect(.exactly(amount: callCount), callsToFunctionWithID: .doThis)
                
            }).then("it doesn't fail", {
                sut.verify()
            })
            
            mockWithVariableAmountOfMethodCalls.andWhen("any amount of calls are expected", {
                
                sut.expect(.anyAmount, callsToFunctionWithID: .doThis)
                
            }).then("it doesn't fail", {
                sut.verify()
            })
            
            mockWithVariableAmountOfMethodCalls.andWhen("\(callCount + 1) of calls are expected", {
                    
                    sut.expect(.exactly(amount: callCount + 1), callsToFunctionWithID: .doThis)
                
            }).then("it fails", {
                expect(sut.wouldFailIfVerified()).to(beTruthy())
            })
        }
        
        let mockThatsExpectingTwoDoThatWithTrueArgCalls = givenAMock.when("expecting two calls with true arguments") {
            
            sut.expect(.exactly(amount: 2),
                       callsToFunctionWithID: .doThatWithBooleanArgument,
                       withArgumentsThatMatch: ArgumentMatcher(matcher: { (booleanArgument: Bool) -> Bool in
                        return booleanArgument == true
                       }))
            
        }
        
        mockThatsExpectingTwoDoThatWithTrueArgCalls.when("doThat is called the expected way") {
            
            sut.doThat(with: true)
            
            }.andWhen("doThat is called the unexpected way") {
                sut.doThat(with: false)
                
                }.then("it fails") {
                    expect(sut.wouldFailIfVerified()).to(beTruthy())
            }
        
        mockThatsExpectingTwoDoThatWithTrueArgCalls.when("do that is called the right way three times") {
            
            sut.doThat(with: true)
            sut.doThat(with: true)
            sut.doThat(with: true)
        }.then("it fails") {
            expect(sut.wouldFailIfVerified()).to(beTruthy())
        }
        
        mockThatsExpectingTwoDoThatWithTrueArgCalls.when("do that is called the right way two times") {
            
            sut.doThat(with: true)
            sut.doThat(with: true)
        }.then("it doesnt fail") {
            sut.verify()
        }
    }
}
