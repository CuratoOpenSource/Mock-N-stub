import XCTest
import Quick
import Nimble
import MockNStub
import QuickGWT

class DefaultStubValuesSpec: QuickSpec {
    
    override func spec() {
        
        given("a stub") {
            
            let sut = StubWithAllTypesThatHaveDefaultStubValue()
            
            when("when asking for a string", closure: {
                
                context("using a selector", {
                    let value = sut.stringUsingSelector()
                    
                    then("default value is correct", closure: {
                        expect(value).to(equal(""))
                    })
                })
                
                context("using a function", {
                    let value = sut.stringUsingFunction()

                    then("default value is correct", closure: {
                        expect(value).to(equal(""))
                    })
                })
            })
        }
    }
}
