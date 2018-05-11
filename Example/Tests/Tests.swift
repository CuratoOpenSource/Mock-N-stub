import XCTest
import Quick
import Nimble
import CanMock

class MockSpec: QuickSpec {
    
    override func spec() {
        describe("Mock") {
            
            var sut: Mock!
            
            beforeEach {
                sut = Mock()
            }
            
            it("has everything you need to get started") {
                sut.expect(callTo: #selector(Mock.doThis))
                sut.expect(callTo: #selector(Mock.doThat))
                sut.expect(callTo: #selector(Mock.say(name:)), withArgumentsThatMatch: { (args) -> (Bool) in
                    return args as! String == "Chris"
                })
                
                sut.expect(callTo: #selector(Mock.say(greeting:to:with:)), withArgumentsThatMatch: { (args) -> (Bool) in
                    return args as! (String, String, UInt) == ("Hello", "Chris", 22)
                })
                
                sut.doThis()
                sut.doThat()
                sut.say(greeting: "Hello", to: "Chris", with: 22)
                
                sut.say(name: "Chris")
                sut.say(name: "Bert")
                
                verify(sut)
            }
        }
    }
}
