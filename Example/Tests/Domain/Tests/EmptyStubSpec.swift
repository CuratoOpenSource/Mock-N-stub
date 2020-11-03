//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import MockNStub

class EmptyStubSpec: QuickSpec {
    
    override func spec() {
        describe("Given a \(EmptyStub.self)") {
            var sut: EmptyStub!

            //MARK: Stubbing
            beforeEach {
                sut = EmptyStub()
            }
            
            context("With a non empty state", {
                
                beforeEach {
                    (0..<10).forEach({ (number) in
                        sut.callValues.append(CallValue(methodID: MethodID.name("\(number)"), value: nil, matcher: anyArgumentMatcher))
                    })
                }
                
                it("Then callValues are not empty", closure: {
                    expect(sut.callValues.count).notTo(equal(0))
                })
                
                context("When resetted", {
                    
                    beforeEach {
                        sut.resetStub()
                    }
                    
                    it("Then callValues are empty", closure: {
                        expect(sut.callValues.count).to(equal(0))
                    })
                })
            })
        }
    }
}
