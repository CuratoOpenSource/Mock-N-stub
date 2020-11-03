//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

import XCTest
import Quick
import Nimble
import MockNStub

class MockTableViewDataSourceUsingFunctionsSpec: QuickSpec {
    
    override func spec() {
        describe("") {
            typealias SUT = MockTableViewDataSourceUsingFunctions
            var sut: MockTableViewDataSourceUsingFunctions!
            let tableView = UITableView()
            let indexPath = IndexPath()
            var mockFailureHandler: MockFailureHandler!
            
            beforeEach {
                sut = MockTableViewDataSourceUsingFunctions()
            }
            
            //MARK: - Mocking
            context("Mocking", {
                beforeEach {
                    sut.given(SUT.Function.tableView_NumberOfRowsInSection, willReturn: 0)
                    sut.given(SUT.Function.tableView_CellForRowAtIndexPath, willReturn: UITableViewCell())
                }
                
                //MARK: Expecting Failures
                context("Expecting failures", {
                    beforeEach {
                        mockFailureHandler = MockFailureHandler()
                        sut.given("failureHandler", willReturn: mockFailureHandler)
                        mockFailureHandler.expect(callToFunctionWithID: .failWithMessageAtLocation)
                    }
                    
                    it("Fails when expected methods are not called", closure: {
                        //Arrange
                        sut.expect(callToFunction: "tableView(:numberOfRowsInSection:)")
                        
                        //Act
                        sut.verify()
                        
                        //Assert
                        mockFailureHandler.verify()
                    })
                    
                    it("Fails when expected methods are not called", closure: {
                        //Arrange
                        sut.expect(callToFunction: "tableView(:cellForRowAt:)")
                        
                        //Act
                        sut.verify()
                        
                        //Assert
                        mockFailureHandler.verify()
                    })
                    
                    it("Fails when expected methods are not called", closure: {
                        //Arrange
                        sut.expect(callToFunction: SUT.Function.tableView_CellForRowAtIndexPath)
                        sut.expect(callToFunction: SUT.Function.tableView_NumberOfRowsInSection)
                        _ = sut.tableView(tableView, cellForRowAt: indexPath)
                        
                        //Act
                        sut.verify()
                        
                        //Assert
                        mockFailureHandler.verify()
                    })
                    
                    it("Fails when expected methods are not called with arguments that don't match", closure: {
                        //Arrange
                        sut.expect(callToFunction: SUT.Function.tableView_NumberOfRowsInSection, withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
                            return args.0 === tableView && args.1 == 42
                        }))
                        _ = sut.tableView(tableView, numberOfRowsInSection: 22)
                        
                        //Act
                        sut.verify()
                        
                        //Assert
                        mockFailureHandler.verify()
                    })
                    
                    it("Fails when expected methods are called with incorrect matcher type", closure: {
                        //Arrange
                        sut.expect(callToFunction: SUT.Function.tableView_NumberOfRowsInSection, withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int, Any)) -> Bool in
                            return args.0 === tableView && args.1 == 42
                        }))
                        _ = sut.tableView(tableView, numberOfRowsInSection: 42)
                        
                        //Act
                        sut.verify()
                        
                        //Assert
                        mockFailureHandler.verify()
                    })
                })
                
                //MARK: Not expecting failures
                context("Not expecting failures", {
                    
                    it("Doesn't fail when expected methods are called", closure: {
                        //Arrange
                        sut.expect(callToFunction: SUT.Function.tableView_NumberOfRowsInSection)
                        
                        //Act
                        _ = sut.tableView(tableView, numberOfRowsInSection: 42)
                        
                        //Assert
                        sut.verify()
                    })
                    
                    it("Doesn't fail when expected methods are called", closure: {
                        //Arrange
                        sut.expect(callToFunction: SUT.Function.tableView_CellForRowAtIndexPath)
                        
                        //Act
                        _ = sut.tableView(tableView, cellForRowAt: indexPath)
                        
                        //Assert
                        sut.verify()
                    })
                    
                    it("Doesn't fail when expected methods are called", closure: {
                        //Arrange
                        sut.expect(callToFunction: SUT.Function.tableView_CellForRowAtIndexPath)
                        sut.expect(callToFunction: SUT.Function.tableView_NumberOfRowsInSection)
                        
                        //Act
                        _ = sut.tableView(tableView, cellForRowAt: indexPath)
                        _ = sut.tableView(tableView, numberOfRowsInSection: 42)
                        
                        //Act
                        sut.verify()
                    })
                    
                    it("Doesn't fail when expected methods are called with arguments that match", closure: {
                        //Arrange
                        sut.expect(callToFunction: SUT.Function.tableView_NumberOfRowsInSection, withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
                            return args.0 === tableView && args.1 == 42
                        }))
                        
                        //Act
                        _ = sut.tableView(tableView, numberOfRowsInSection: 42)
                        
                        //Assert
                        sut.verify()
                    })
                })
            })
            
            //MARK: - Stubbing
            context("Stubbing", {
                it("Provides the correct returnValue", closure: {
                    //Arrange
                    sut.given(SUT.Function.tableView_NumberOfRowsInSection, willReturn: 42)
                    
                    //Assert
                    expect(sut.tableView(tableView, numberOfRowsInSection: 5)).to(equal(42))
                })
                
                it("Provides the correct returnValue", closure: {
                    //Arrange
                    sut.given(SUT.Function.tableView_NumberOfRowsInSection, willReturn: 10)
                    sut.given(SUT.Function.tableView_NumberOfRowsInSection, willReturn: 42)
                    
                    //Assert
                    expect(sut.tableView(tableView, numberOfRowsInSection: 6)).to(equal(42))
                })
                
                it("Provides the correct returnValue", closure: {
                    //Arrange
                    sut.given(SUT.Function.tableView_NumberOfRowsInSection, withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
                        args.1 == 1
                    }), willReturn: 22)
                    sut.given(SUT.Function.tableView_NumberOfRowsInSection, withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
                        args.1 == 2
                    }), willReturn: 42)
                    
                    //Assert
                    expect(sut.tableView(tableView, numberOfRowsInSection: 1)).to(equal(22))
                    expect(sut.tableView(tableView, numberOfRowsInSection: 2)).to(equal(42))
                })
            })
        }
    }
}
