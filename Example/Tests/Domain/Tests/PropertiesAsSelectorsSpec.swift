import XCTest
import Quick
import Nimble
import MockNStub

class PropertiesAsSelectorsSpec: QuickSpec {
    
    override func spec() {
        describe("Given a Mock with full name and optional nickname") {
            var sut: MockContainingFullnameAndOptionalNicknameUsingSelectors!

            //MARK: Stubbing
            beforeEach {
                sut = MockContainingFullnameAndOptionalNicknameUsingSelectors()
            }
            
            context("When fullName is stubbed", closure: {
                beforeEach {
                    sut.given(#selector(getter: sut.fullName), willReturn: "Taylor Swift")
                }
                
                it("Then  it provides correct fullName", closure: {
                    XCTAssertEqual(sut.fullName, "Taylor Swift")
                })
                
                it("Then  it provides correct nickname", closure: {
                    XCTAssertEqual(sut.nickname, nil)
                })
            })
            
            context("When nickname is stubbed", closure: {
                beforeEach {
                    sut.given(#selector(getter: sut.nickname), willReturn: "TS")
                }
                
                it("Then  it provides correct nickName", closure: {
                    XCTAssertEqual(sut.nickname, "TS")
                })
            })
            
            //MARK: Mocking
            context("When fullName is set", closure: {
                beforeEach {
                    sut.fullName = "Other Name"
                }

                context("And  that fullName is expected to be set", closure: {
                    beforeEach {
                        sut.expect(callToSelector: #selector(setter: sut.fullName), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: String) -> Bool in
                            return args == "Other Name"
                        }))
                    }

                    it("Then  it doesnt fail verification", closure: {
                        sut.verify()
                    })
                })
            })
            
            context("When nickname is set", closure: {
                context("to nil", {
                    beforeEach {
                        sut.nickname = nil
                    }
                    
                    context("And  nil is expected to be set", closure: {
                        beforeEach {
                            sut.expect(callToSelector: #selector(setter: sut.nickname), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: String?) -> Bool in
                                return args == nil
                            }))
                        }
                        
                        it("Then  it doesnt fail verification", closure: {
                            sut.verify()
                        })
                    })
                })
                
                context("to non nil string", {
                    beforeEach {
                        sut.nickname = "Other Nickname"
                    }
                    
                    context("And  that nickname expected to be set", closure: {
                        beforeEach {
                            sut.expect(callToSelector: #selector(setter: sut.nickname), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: String?) -> Bool in
                                return args == "Other Nickname"
                            }))
                        }
                        
                        it("Then  it doesnt fail verification", closure: {
                            sut.verify()
                        })
                    })
                })
            })
        }
    }
}
