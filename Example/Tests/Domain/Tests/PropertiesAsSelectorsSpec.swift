import XCTest
import Quick
import QuickGWT
import Nimble
import MockNStub

class PropertiesAsSelectorsSpec: QuickSpec {
    
    override func spec() {
        given("Mock with full name and optional nickname") {
            var sut: MockContainingFullnameAndOptionalNicknameUsingSelectors!

            //MARK: Stubbing
            beforeEach {
                sut = MockContainingFullnameAndOptionalNicknameUsingSelectors()
            }
            
            when("fullName is stubbed", closure: {
                beforeEach {
                    sut.given(#selector(getter: sut.fullName), willReturn: "Taylor Swift")
                }
                
                then("it provides correct fullName", closure: {
                    XCTAssertEqual(sut.fullName, "Taylor Swift")
                })
                
                then("it provides correct nickname", closure: {
                    XCTAssertEqual(sut.nickname, nil)
                })
            })
            
            when("nickname is stubbed", closure: {
                beforeEach {
                    sut.given(#selector(getter: sut.nickname), willReturn: "TS")
                }
                
                then("it provides correct nickName", closure: {
                    XCTAssertEqual(sut.nickname, "TS")
                })
            })
            
            //MARK: Mocking
            when("fullName is set", closure: {
                beforeEach {
                    sut.fullName = "Other Name"
                }

                and("that fullName is expected to be set", closure: {
                    beforeEach {
                        sut.expect(callToSelector: #selector(setter: sut.fullName), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: String) -> Bool in
                            return args == "Other Name"
                        }))
                    }

                    then("it doesnt fail verification", closure: {
                        sut.verify()
                    })
                })
            })
            
            when("nickname is set", closure: {
                context("to nil", {
                    beforeEach {
                        sut.nickname = nil
                    }
                    
                    and("nil is expected to be set", closure: {
                        beforeEach {
                            sut.expect(callToSelector: #selector(setter: sut.nickname), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: String?) -> Bool in
                                return args == nil
                            }))
                        }
                        
                        then("it doesnt fail verification", closure: {
                            sut.verify()
                        })
                    })
                })
                
                context("to non nil string", {
                    beforeEach {
                        sut.nickname = "Other Nickname"
                    }
                    
                    and("that nickname expected to be set", closure: {
                        beforeEach {
                            sut.expect(callToSelector: #selector(setter: sut.nickname), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: String?) -> Bool in
                                return args == "Other Nickname"
                            }))
                        }
                        
                        then("it doesnt fail verification", closure: {
                            sut.verify()
                        })
                    })
                })
            })
        }
    }
}
