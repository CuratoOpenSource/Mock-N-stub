import XCTest
import Quick
import Nimble
import MockNStub
import QuickGWT

class DefaultStubValuesSpec: QuickSpec {
    
    override func spec() {
        
        given("a stub") {
            
            var sut: StubWithAllTypesThatHaveDefaultStubValue!
            
            beforeEach {
                sut = StubWithAllTypesThatHaveDefaultStubValue()
            }
            
            when("when asking for a string", closure: {
                
                context("using a selector", {
                    let defaultStubValue = sut.stringUsingSelector()
                    
                    then("default value is correct", closure: {
                        expect(defaultStubValue).to(equal(""))
                    })
                })
                
                context("using a function", {
                    let defaultStubValue = sut.stringUsingFunction()
                    
                    then("default value is correct", closure: {
                        expect(defaultStubValue).to(equal(""))
                    })
                })
            })
        }
    }
}
