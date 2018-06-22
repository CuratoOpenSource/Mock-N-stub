import XCTest
import Quick
import Nimble
@testable import MockNStub
import QuickGWT
import InjectableLoggers

class LoggerSpec: QuickSpec {
    
    override func spec() {
        
        given("the logger instance") {
            
            let sut = logger
            
            when("setting are asked", closure: {
                
                let settings = sut.settings
                
                then("their active loglevel is Info", closure: {
                    
                    expect(settings.activeLogLevel).to(equal(Loglevel.info))
                })
            })
        }
    }
}
