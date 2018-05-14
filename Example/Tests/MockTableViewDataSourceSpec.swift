import XCTest
import Quick
import Nimble
import CanMock

class MockTableViewDataSourceSpec: QuickSpec {
    
    override func spec() {
        describe("") {
            
            var sut: MockTableViewDataSource!
            let tableView = UITableView()
            let indexPath = IndexPath()
            var mockFailureHandler: MockFailureHandler!
            
            beforeEach {
                sut = MockTableViewDataSource()
            }
            
            //MARK: - Mocking
            context("Mocking", {
                beforeEach {
                    sut.given(#selector(sut.tableView(_:numberOfRowsInSection:)), willReturn: 0)
                    sut.given(#selector(sut.tableView(_:cellForRowAt:)), willReturn: UITableViewCell())
                }
                
                //MARK: Expecting Failures
                context("Expecting failures", {
                    beforeEach {
                        mockFailureHandler = MockFailureHandler()
                        sut.given("failureHandler", willReturn: mockFailureHandler)
                        mockFailureHandler.expect(callTo: "fail(with:at:)")
                    }
                    
                    //MARK: Methods
                    context("Methods", {
                        it("Fails when expected methods are not called", closure: {
                            //Arrange
                            sut.expect(callTo: "tableView(:numberOfRowsInSection:)")
                            
                            //Act
                            sut.verify()
                            
                            //Assert
                            mockFailureHandler.verify()
                        })
                        
                        it("Fails when expected methods are not called", closure: {
                            //Arrange
                            sut.expect(callTo: "tableView(:cellForRowAt:)")
                            
                            //Act
                            sut.verify()
                            
                            //Assert
                            mockFailureHandler.verify()
                        })
                        
                        it("Fails when expected methods are not called", closure: {
                            //Arrange
                            sut.expect(callTo: #selector(sut.tableView(_:cellForRowAt:)))
                            sut.expect(callTo: #selector(sut.tableView(_:numberOfRowsInSection:)))
                            _ = sut.tableView(tableView, cellForRowAt: indexPath)
                            
                            //Act
                            sut.verify()
                            
                            //Assert
                            mockFailureHandler.verify()
                        })
                        
                        it("Fails when expected methods are not called with arguments that don't match", closure: {
                            //Arrange
                            sut.expect(callTo: #selector(sut.tableView(_:numberOfRowsInSection:)), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
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
                            sut.expect(callTo: #selector(sut.tableView(_:numberOfRowsInSection:)), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int, Any)) -> Bool in
                                return args.0 === tableView && args.1 == 42
                            }))
                            _ = sut.tableView(tableView, numberOfRowsInSection: 42)
                            
                            //Act
                            sut.verify()
                            
                            //Assert
                            mockFailureHandler.verify()
                        })
                    })
                    
                    //MARK: Selectors
                    context("Selectors", {
                        it("Fails when expected methods are not called", closure: {
                            //Arrange
                            sut.expect(callTo: #selector(sut.tableView(_:numberOfRowsInSection:)))
                            
                            //Act
                            sut.verify()
                            
                            //Assert
                            mockFailureHandler.verify()
                        })
                        
                        it("Fails when expected methods are not called", closure: {
                            //Arrange
                            sut.expect(callTo: #selector(sut.tableView(_:cellForRowAt:)))
                            
                            //Act
                            sut.verify()
                            
                            //Assert
                            mockFailureHandler.verify()
                        })
                        
                        it("Fails when expected methods are not called", closure: {
                            //Arrange
                            sut.expect(callTo: #selector(sut.tableView(_:cellForRowAt:)))
                            sut.expect(callTo: #selector(sut.tableView(_:numberOfRowsInSection:)))
                            _ = sut.tableView(tableView, cellForRowAt: indexPath)
                            
                            //Act
                            sut.verify()
                            
                            //Assert
                            mockFailureHandler.verify()
                        })
                        
                        it("Fails when expected methods are not called with arguments that don't match", closure: {
                            //Arrange
                            sut.expect(callTo: #selector(sut.tableView(_:numberOfRowsInSection:)), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
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
                            sut.expect(callTo: #selector(sut.tableView(_:numberOfRowsInSection:)), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int, Any)) -> Bool in
                                return args.0 === tableView && args.1 == 42
                            }))
                            _ = sut.tableView(tableView, numberOfRowsInSection: 42)
                            
                            //Act
                            sut.verify()
                            
                            //Assert
                            mockFailureHandler.verify()
                        })
                    })
                })
                
                //MARK: Not expecting failures
                context("Not expecting failures", {
                    //MARK: Selectors
                    context("Selectors", {
                        it("Doesn't fail when expected methods are called", closure: {
                            //Arrange
                            sut.expect(callTo: #selector(sut.tableView(_:numberOfRowsInSection:)))
                            
                            //Act
                            _ = sut.tableView(tableView, numberOfRowsInSection: 42)
                            
                            //Assert
                            sut.verify()
                        })
                        
                        it("Doesn't fail when expected methods are called", closure: {
                            //Arrange
                            sut.expect(callTo: #selector(sut.tableView(_:cellForRowAt:)))
                            
                            //Act
                            _ = sut.tableView(tableView, cellForRowAt: indexPath)
                            
                            //Assert
                            sut.verify()
                        })
                        
                        it("Doesn't fail when expected methods are called", closure: {
                            //Arrange
                            sut.expect(callTo: #selector(sut.tableView(_:cellForRowAt:)))
                            sut.expect(callTo: #selector(sut.tableView(_:numberOfRowsInSection:)))
                            
                            //Act
                            _ = sut.tableView(tableView, cellForRowAt: indexPath)
                            _ = sut.tableView(tableView, numberOfRowsInSection: 42)
                            
                            //Act
                            sut.verify()
                        })
                        
                        it("Doesn't fail when expected methods are called with arguments that match", closure: {
                            //Arrange
                            sut.expect(callTo: #selector(sut.tableView(_:numberOfRowsInSection:)), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
                                return args.0 === tableView && args.1 == 42
                            }))
                            
                            //Act
                            _ = sut.tableView(tableView, numberOfRowsInSection: 42)
                            
                            //Assert
                            sut.verify()
                        })
                    })
                    
                    //MARK: Methods
                    context("Methods", {
                        it("Doesn't fail when expected methods are called", closure: {
                            //Arrange
                            sut.expect(callTo: "tableView(_:numberOfRowsInSection:)")
                            
                            //Act
                            _ = sut.tableView(tableView, numberOfRowsInSection: 42)
                            
                            //Assert
                            sut.verify()
                        })
                        
                        it("Doesn't fail when expected methods are called", closure: {
                            //Arrange
                            sut.expect(callTo: "tableView(_:cellForRowAt:)")
                            
                            //Act
                            _ = sut.tableView(tableView, cellForRowAt: indexPath)
                            
                            //Assert
                            sut.verify()
                        })
                        
                        it("Doesn't fail when expected methods are called", closure: {
                            //Arrange
                            sut.expect(callTo: "tableView(_:cellForRowAt:)")
                            sut.expect(callTo: "tableView(_:numberOfRowsInSection:)")
                            
                            //Act
                            _ = sut.tableView(tableView, cellForRowAt: indexPath)
                            _ = sut.tableView(tableView, numberOfRowsInSection: 42)
                            
                            //Act
                            sut.verify()
                        })
                        
                        it("Doesn't fail when expected methods are called with arguments that match", closure: {
                            //Arrange
                            sut.expect(callTo: "tableView(_:numberOfRowsInSection:)", withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
                                return args.0 === tableView && args.1 == 42
                            }))
                            
                            //Act
                            _ = sut.tableView(tableView, numberOfRowsInSection: 42)
                            
                            //Assert
                            sut.verify()
                        })
                    })
                })
            })
            
            //MARK: - Stubbing
            context("Stubbing", {
                //MARK: Selectors
                context("Selectors", {
                    it("Provides the correct returnValue", closure: {
                        //Arrange
                        sut.given(#selector(sut.tableView(_:numberOfRowsInSection:)), willReturn: 42)
                        
                        //Assert
                        expect(sut.tableView(tableView, numberOfRowsInSection: 2)).to(equal(42))
                    })
                    
                    it("Provides the correct returnValue", closure: {
                        //Arrange
                        sut.given(#selector(sut.tableView(_:numberOfRowsInSection:)), willReturn: 10)
                        sut.given(#selector(sut.tableView(_:numberOfRowsInSection:)), willReturn: 42)
                        
                        //Assert
                        expect(sut.tableView(tableView, numberOfRowsInSection: 2)).to(equal(42))
                    })
                    
                    it("Provides the correct returnValue", closure: {
                        //Arrange
                        sut.given(#selector(sut.tableView(_:numberOfRowsInSection:)), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
                            args.1 == 1
                        }), willReturn: 22)
                        sut.given(#selector(sut.tableView(_:numberOfRowsInSection:)), withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
                            args.1 == 2
                        }), willReturn: 42)
                        
                        //Assert
                        expect(sut.tableView(tableView, numberOfRowsInSection: 1)).to(equal(22))
                        expect(sut.tableView(tableView, numberOfRowsInSection: 2)).to(equal(42))
                    })
                })
                
                //MARK: Methods
                context("Methods", {
                    it("Provides the correct returnValue", closure: {
                        //Arrange
                        sut.given("tableView(_:numberOfRowsInSection:)", willReturn: 42)
                        
                        //Assert
                        expect(sut.tableView(tableView, numberOfRowsInSection: 5)).to(equal(42))
                    })
                    
                    it("Provides the correct returnValue", closure: {
                        //Arrange
                        sut.given("tableView(_:numberOfRowsInSection:)", willReturn: 10)
                        sut.given("tableView(_:numberOfRowsInSection:)", willReturn: 42)
                        
                        //Assert
                        expect(sut.tableView(tableView, numberOfRowsInSection: 6)).to(equal(42))
                    })
                    
                    it("Provides the correct returnValue", closure: {
                        //Arrange
                        sut.given("tableView(_:numberOfRowsInSection:)", withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
                            args.1 == 1
                        }), willReturn: 22)
                        sut.given("tableView(_:numberOfRowsInSection:)", withArgumentsThatMatch: ArgumentMatcher(matcher: { (args: (UITableView, Int)) -> Bool in
                            args.1 == 2
                        }), willReturn: 42)
                        
                        //Assert
                        expect(sut.tableView(tableView, numberOfRowsInSection: 1)).to(equal(22))
                        expect(sut.tableView(tableView, numberOfRowsInSection: 2)).to(equal(42))
                    })
                })
            })
        }
    }
}
