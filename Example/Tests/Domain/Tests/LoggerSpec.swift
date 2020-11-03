//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import MockNStub
import InjectableLoggers

class LoggerSpec: QuickSpec {
    
    override func spec() {
        
        describe("Given the logger instance") {
            
            var sut: Logger!
            
            beforeEach {
                sut = logger
            }
            
            context("When setting are asked", closure: {
                
                it("Then their active loglevel is Info", closure: {
                    
                    expect(sut.settings.activeLogLevel).to(equal(Loglevel.info))
                })
            })
        }
    }
}
