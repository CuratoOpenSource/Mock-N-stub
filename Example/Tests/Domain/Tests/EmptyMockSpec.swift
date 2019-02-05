import XCTest
import Quick
import Nimble
@testable import MockNStub

class EmptyMockSpec: QuickSpec {
    
    override func spec() {
        describe("Given a \(EmptyMock.self)") {
            var sut: EmptyMock!

            //MARK: Stubbing
            beforeEach {
                sut = EmptyMock()
            }
            
            context("With a non empty state", {
                
                beforeEach {
                    (0..<10).forEach({ (number) in
                        sut.callValues.append(CallValue(methodID: MethodID.name("\(number)"), value: nil, matcher: anyArgumentMatcher))
                        sut.calls.append(Call(methodID: MethodID.name("\(number)"), arguments: false))
                        sut.verifications.append(Verification(methodID: MethodID.name("\(number)"), matcher: anyArgumentMatcher))
                    })
                }
                
                it("Then callValues are not empty", closure: {
                    expect(sut.callValues.count).notTo(equal(0))
                })
                
                it("Then calls are not empty", closure: {
                    expect(sut.calls.count).notTo(equal(0))
                })
                
                it("Then verifications are not empty", closure: {
                    expect(sut.verifications.count).notTo(equal(0))
                })
                
                context("When resetted", {
                    
                    beforeEach {
                        sut.reset()
                    }
                    
                    it("Then callValues are empty", closure: {
                        expect(sut.callValues.count).to(equal(0))
                    })
                    
                    it("Then calls are empty", closure: {
                        expect(sut.calls.count).to(equal(0))
                    })
                    
                    it("Then verifications are empty", closure: {
                        expect(sut.verifications.count).to(equal(0))
                    })
                })
            })
        }
    }
}
