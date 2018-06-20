import XCTest
import Quick
import Nimble
import MockNStub
import QuickGWT

class DefaultStubValuesSpec: QuickSpec {
    
    override func spec() {
        
        given("a stub") {
            
            let sut = StubWithAllTypesThatHaveDefaultStubValue()
            
            //MARK: Swift types
            when("asking for a String", closure: {
                
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
            
            when("asking for an Array", closure: {
                let value = sut.array()
                
                then("default value is correct", closure: {
                    expect(value).to(equal([]))
                })
            })
            
            when("asking for a Dictionary", closure: {
                let value = sut.dictionary()
                
                then("default value is correct", closure: {
                    expect(value).to(equal([:]))
                })
            })
            
            when("asking for a Set", closure: {
                let value = sut.set()
                
                then("default value is correct", closure: {
                    expect(value).to(equal([]))
                })
            })
            
            when("asking for an Int", closure: {
                let value = sut.int()
                
                then("default value is correct", closure: {
                    expect(value).to(equal(0))
                })
            })
            
            when("asking for a Bool", closure: {
                let value = sut.bool()
                
                then("default value is correct", closure: {
                    expect(value).to(equal(false))
                })
            })
            
            when("asking for a Float", closure: {
                let value = sut.float()
                
                then("default value is correct", closure: {
                    expect(value).to(equal(0))
                })
            })
            
            when("asking for a Double", closure: {
                let value = sut.double()
                
                then("default value is correct", closure: {
                    expect(value).to(equal(0))
                })
            })
        }
    }
}
