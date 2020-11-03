//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

import XCTest
import Quick
import Nimble
import MockNStub

class MethodIDSpec: QuickSpec {
    
    override func spec() {
        
        describe("Given two MethodID's") {
            
            context("When their names are the same", closure: {
                let id1 = MethodID.name(#function)
                let id2 = MethodID.name(#function)
                
                it("Then  they should be equal", closure: {
                    expect(id1).to(equal(id2))
                })
            })

            context("When their names are not the same", closure: {
                let id1 = MethodID.name(#function)
                let id2 = MethodID.name(#function.appending(" "))
                
                it("Then  they should not be equal", closure: {
                    expect(id1).notTo(equal(id2))
                })
            })
        }
    }
}
