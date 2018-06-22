import XCTest
import Quick
import Nimble
import MockNStub
import QuickGWT

class DefaultStubValuesSpec: QuickSpec {
    
    override func spec() {
        
        given("a stub") {
            
            let sut = StubWithAllTypesThatHaveDefaultStubValue()
            
            //MARK: Swift types
            when("asking for a String", closure: {
                
                context("using a selector", {
                    let value = sut.stringUsingSelector()
                    
                    then("default value is correct", closure: {
                        expect(value).to(equal(""))
                    })
                })
                
                context("using a function", {
                    let value = sut.stringUsingFunction()

                    then("default value is correct", closure: {
                        expect(value).to(equal(""))
                    })
                })
            })
            
            when("asking for an Array", closure: {
                let value = sut.array()
                
                then("default value is correct", closure: {
                    expect(value).to(equal([]))
                })
            })
            
            when("asking for a Dictionary", closure: {
                let value = sut.dictionary()
                
                then("default value is correct", closure: {
                    expect(value).to(equal([:]))
                })
            })
            
            when("asking for a Set", closure: {
                let value = sut.set()
                
                then("default value is correct", closure: {
                    expect(value).to(equal([]))
                })
            })
            
            when("asking for an Int", closure: {
                let value = sut.int()
                
                then("default value is correct", closure: {
                    expect(value).to(equal(0))
                })
            })
            
            when("asking for a Bool", closure: {
                let value = sut.bool()
                
                then("default value is correct", closure: {
                    expect(value).to(equal(false))
                })
            })
            
            when("asking for a Float", closure: {
                let value = sut.float()
                
                then("default value is correct", closure: {
                    expect(value).to(equal(0))
                })
            })
            
            when("asking for a Double", closure: {
                let value = sut.double()
                
                then("default value is correct", closure: {
                    expect(value).to(equal(0))
                })
            })
            
            //MARK: UIKit types
            when("asking for a UIColor", closure: {
                let value = sut.color()
                
                then("default value is correct", closure: {
                    expect(value).to(beAKindOf(UIColor.self))
                })
            })
            
            when("asking for a UIView", closure: {
                let value = sut.view()
                
                then("default value is correct", closure: {
                    expect(value).to(beAKindOf(UIView.self))
                })
            })
            
            when("asking for a UILabel", closure: {
                let value = sut.label()
                
                then("default value is correct", closure: {
                    expect(value).to(beAKindOf(UILabel.self))
                })
            })
            
            when("asking for a UIButton", closure: {
                let value = sut.button()
                
                then("default value is correct", closure: {
                    expect(value).to(beAKindOf(UIButton.self))
                })
            })
            
            when("asking for a UIViewController", closure: {
                let value = sut.viewController()
                
                then("default value is correct", closure: {
                    expect(value).to(beAKindOf(UIViewController.self))
                })
            })
            
            when("asking for a UITabBarController", closure: {
                let value = sut.tabbarController()
                
                then("default value is correct", closure: {
                    expect(value).to(beAKindOf(UITabBarController.self))
                })
            })
            
            when("asking for a UINavigationController", closure: {
                let value = sut.navigationController()
                
                then("default value is correct", closure: {
                    expect(value).to(beAKindOf(UINavigationController.self))
                })
            })
            
            when("asking for a UIBarbuttonItem", closure: {
                let value = sut.tabbarController()
                
                then("default value is correct", closure: {
                    expect(value).to(beAKindOf(UITabBarController.self))
                })
            })
            
            when("asking for a UIEdgeInsets", closure: {
                let value = sut.edgeInsets()
                
                then("default value is correct", closure: {
                    expect(value).to(equal(.zero))
                })
            })
            
            //MARK: CoreGraphics Types
            when("asking for a CGFloat", closure: {
                let value = sut.cgFloat()
                
                then("default value is correct", closure: {
                    expect(value).to(equal(0))
                })
            })
            
            when("asking for a CGSize", closure: {
                let value = sut.cgSize()
                
                then("default value is correct", closure: {
                    expect(value).to(equal(.zero))
                })
            })
            
            when("asking for a CGPoint", closure: {
                let value = sut.cgPoint()
                
                then("default value is correct", closure: {
                    expect(value).to(equal(.zero))
                })
            })
            
            when("asking for a CGRect", closure: {
                let value = sut.cgRect()
                
                then("default value is correct", closure: {
                    expect(value).to(equal(.zero))
                })
            })
            
            when("asking for a CGAffineTransform", closure: {
                let value = sut.cgAffineTransForm()
                
                then("default value is correct", closure: {
                    expect(value).to(beAKindOf(CGAffineTransform.self))
                })
            })
        }
    }
}
