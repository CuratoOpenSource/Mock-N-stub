import XCTest
import Quick
import Nimble
import MockNStub
import QuickGWT

class MethodIDSpec: QuickSpec {
    
    override func spec() {
        
        given("two MethodID's") {
            
            when("their names are the same", closure: {
                let id1 = MethodID.name(#function)
                let id2 = MethodID.name(#function)
                
                then("they should be equal", closure: {
                    expect(id1).to(equal(id2))
                })
            })
            
            when("their selectors are the same", closure: {
                let id1 = MethodID.selector(#selector(getter: MockContainingFullnameAndOptionalNicknameUsingSelectors.fullName))
                let id2 = MethodID.selector(#selector(getter: MockContainingFullnameAndOptionalNicknameUsingSelectors.fullName))
                
                then("they should be equal", closure: {
                    expect(id1).to(equal(id2))
                })
            })
            
            when("their names are not the same", closure: {
                let id1 = MethodID.name(#function)
                let id2 = MethodID.name(#function.appending(" "))
                
                then("they should not be equal", closure: {
                    expect(id1).notTo(equal(id2))
                })
            })
            
            when("their selectors are not the same", closure: {
                let id1 = MethodID.selector(#selector(getter: MockContainingFullnameAndOptionalNicknameUsingSelectors.fullName))
                let id2 = MethodID.selector(#selector(getter: MockContainingFullnameAndOptionalNicknameUsingSelectors.nickname))
                
                then("they should be equal", closure: {
                    expect(id1).notTo(equal(id2))
                })
            })
        }
    }
}
