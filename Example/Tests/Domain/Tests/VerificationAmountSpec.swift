import XCTest
import Quick
import Nimble
import MockNStub

class VerificationAmountSpec: QuickSpec {
    
    override func spec() {
        
        var sut: MockWithFunctionIDs!
        
        (1...3).forEach { (callCount) in
            
            let mockWithVariableAmountOfMethodCalls = Given(a: MockWithFunctionIDs.self, {
                
                sut = MockWithFunctionIDs()
                
            }).when("a method is called \(callCount) times", {
                
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
    }
}
