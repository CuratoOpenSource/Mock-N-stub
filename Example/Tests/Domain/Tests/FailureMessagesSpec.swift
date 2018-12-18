import XCTest
import Quick
import Nimble
import MockNStub

class EmptyMock: Mocking {}

class FailureMessagesSpec: QuickSpec {
    
    override func spec() {
        describe("Given a Mock") {
            
            var sut: EmptyMock!
            var mockFailureHandler: MockFailureHandler!
            
            beforeEach {
                sut = EmptyMock()
                mockFailureHandler = MockFailureHandler()
                sut.given("failureHandler", willReturn: mockFailureHandler)
            }
            
            //MARK: - Mocking
            context("That's expecting a call to foo", {
                
                beforeEach {
                    sut.expect(callToFunction: "foo")
                }
                
                context("When no calls have been made", {
                    
                    it("Then it fails with expected message", closure: {
                        
                        mockFailureHandler.expect(callToFunctionWithID: MockFailureHandler.FID.failWithMessageAtLocation, 
                                                  withArgumentsThatMatch: ArgumentMatcher(matcher: { (message: String, location: Location) -> Bool in
                            expect(message).to(equal("Could not verify call to `foo`"))
                            return true
                        }))
                        
                        sut.verify()
                        mockFailureHandler.verify()
                    })
                })
                
                context("When one call has been made", {
                    
                    beforeEach {
                        sut.didCallFunction("callOne")
                    }
                    
                    it("Then it fails with expected message", closure: {
                        
                        mockFailureHandler.expect(callToFunctionWithID: MockFailureHandler.FID.failWithMessageAtLocation,
                                                  withArgumentsThatMatch: ArgumentMatcher(matcher: { (message: String, location: Location) -> Bool in
                                                    expect(message).to(equal("""
Could not verify call to `foo`

however, the following calls have been registered:
-callOne
"""))
                                                    return true
                                                  }))
                        
                        sut.verify()
                        mockFailureHandler.verify()
                    })
                    
                    context("And another call has been made", {
                        
                        var randomInt: Int!
                        var randomString: String!
                        
                        beforeEach {
                            randomInt = Int.random(in: 0...9)
                            randomString = "\(Int.random(in: 0...9))"
                            
                            sut.didCallFunction("callTwo")
                        }
                        
                        it("Then it fails with expected message", closure: {
                            
                            mockFailureHandler.expect(callToFunctionWithID: MockFailureHandler.FID.failWithMessageAtLocation,
                                                      withArgumentsThatMatch: ArgumentMatcher(matcher: { (message: String, location: Location) -> Bool in
                                                        expect(message).to(equal("""
Could not verify call to `foo`

however, the following calls have been registered:
-callOne
-callTwo \(randomInt!), \(randomString!)
"""))
                                                        return true
                                                      }))
                            
                            sut.verify()
                            mockFailureHandler.verify()
                        })
                    })
                })
            })
        }
    }
}
