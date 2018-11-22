import XCTest
import Quick
import Nimble
@testable import MockNStub
import InjectableLoggers

class LoggerSpec: QuickSpec {
    
    override func spec() {
        
        describe("Given the logger instance") {
            
            let sut = logger
            
            context("When setting are asked", closure: {
                
                let settings = sut.settings
                
                it("Then  their active loglevel is Info", closure: {
                    
                    expect(settings.activeLogLevel).to(equal(Loglevel.info))
                })
            })
        }
    }
}
