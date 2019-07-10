import XCTest
import Quick
import Nimble
@testable import MockNStub

class FunctionIDSpec: QuickSpec {
    
    override func spec() {
        
        var sut: MockWithFunctionIDs!
        
        let givenAMockThatsAvailable = Given(a: MockWithFunctionIDs.self, {
            sut = MockWithFunctionIDs()
        })
        
        [MockWithFunctionIDs.FuncID.doThis,
         MockWithFunctionIDs.FuncID.doThatWithBooleanArgument].forEach({ (funcID) in
        
            givenAMockThatsAvailable.when("a call is registered using functionID \(funcID)", {
                
                sut.didCallFunction(withID: funcID)
                
                }).andWhen("a call is registered using function name \(funcID.rawValue)", {
                    
                    sut.didCallFunction(funcID.rawValue)
                    
                    }).then("number of registered calls is correct", {
                        expect(sut.calls.count).to(equal(2))
                        
                    }).then("Then created MethodID's are correct", {
                        expect(sut.calls[0].methodID).to(equal(sut.calls[1].methodID))
                    })

            
            givenAMockThatsAvailable.when("a call is expected using functionID \(funcID)", {
                
                sut.expect(callToFunctionWithID: funcID)
                
                }).andWhen("And when a call is expected using function name \(funcID.rawValue)", {
                    
                        sut.expect(callToFunction: funcID.rawValue)
                    
                    }).then("Then number of registered calls is correct", {
                        expect(sut.verifications.count).to(equal(2))
                        
                    }).then("Then created MethodID's are correct", {
                        expect(sut.verifications[0].methodID).to(equal(sut.verifications[1].methodID))
                    })
         })
    }
}
