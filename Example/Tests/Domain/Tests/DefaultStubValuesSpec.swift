import XCTest
import Quick
import Nimble
import MockNStub

class DefaultStubValuesSpec: QuickSpec {
    
    override func spec() {
        
        describe("Given a stub") {
            
            let sut = StubWithAllTypesThatHaveDefaultStubValue()
            
            //MARK: Swift types
            context("When asking for a String", closure: {
                
                context("using a selector", {
                    let value = sut.stringUsingSelector()
                    
                    it("Then  default value is correct", closure: {
                        expect(value).to(equal(""))
                    })
                })
                
                context("using a function", {
                    let value = sut.stringUsingFunction()

                    it("Then  default value is correct", closure: {
                        expect(value).to(equal(""))
                    })
                })
            })
            
            context("When asking for an Array", closure: {
                let value = sut.array()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(equal([]))
                })
            })
            
            context("When asking for a Dictionary", closure: {
                let value = sut.dictionary()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(equal([:]))
                })
            })
            
            context("When asking for a Set", closure: {
                let value = sut.set()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(equal([]))
                })
            })
            
            context("When asking for an Int", closure: {
                let value = sut.int()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(equal(0))
                })
            })
            
            context("When asking for a Bool", closure: {
                let value = sut.bool()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(equal(false))
                })
            })
            
            context("When asking for a Float", closure: {
                let value = sut.float()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(equal(0))
                })
            })
            
            context("When asking for a Double", closure: {
                let value = sut.double()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(equal(0))
                })
            })
            
            //MARK: UIKit types
            context("When asking for a UIColor", closure: {
                let value = sut.color()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(beAKindOf(UIColor.self))
                })
            })
            
            context("When asking for a UIView", closure: {
                let value = sut.view()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(beAKindOf(UIView.self))
                })
            })
            
            context("When asking for a UILabel", closure: {
                let value = sut.label()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(beAKindOf(UILabel.self))
                })
            })
            
            context("When asking for a UIButton", closure: {
                let value = sut.button()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(beAKindOf(UIButton.self))
                })
            })
            
            context("When asking for a UIViewController", closure: {
                let value = sut.viewController()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(beAKindOf(UIViewController.self))
                })
            })
            
            context("When asking for a UITabBarController", closure: {
                let value = sut.tabbarController()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(beAKindOf(UITabBarController.self))
                })
            })
            
            context("When asking for a UINavigationController", closure: {
                let value = sut.navigationController()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(beAKindOf(UINavigationController.self))
                })
            })
            
            context("When asking for a UIBarbuttonItem", closure: {
                let value = sut.tabbarController()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(beAKindOf(UITabBarController.self))
                })
            })
            
            context("When asking for a UIEdgeInsets", closure: {
                let value = sut.edgeInsets()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(equal(.zero))
                })
            })
            
            //MARK: CoreGraphics Types
            context("When asking for a CGFloat", closure: {
                let value = sut.cgFloat()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(equal(0))
                })
            })
            
            context("When asking for a CGSize", closure: {
                let value = sut.cgSize()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(equal(.zero))
                })
            })
            
            context("When asking for a CGPoint", closure: {
                let value = sut.cgPoint()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(equal(.zero))
                })
            })
            
            context("When asking for a CGRect", closure: {
                let value = sut.cgRect()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(equal(.zero))
                })
            })
            
            context("When asking for a CGAffineTransform", closure: {
                let value = sut.cgAffineTransForm()
                
                it("Then  default value is correct", closure: {
                    expect(value).to(beAKindOf(CGAffineTransform.self))
                })
            })
        }
    }
}
