import XCTest
import Quick
import Nimble
import CanMock

class TableViewSpec: QuickSpec {
    
    override func spec() {
        describe("Mock") {
            
            var sut: MockTableViewDataSource!
            var tableView: UITableView!
            
            context("DataSource", {
                beforeEach {
                    sut = MockTableViewDataSource()
                    tableView = UITableView()
                }
                
                it("calls the expected dataSource methods") {
                    //Arrange
                    sut.expect(callTo: #selector(sut.tableView(_:numberOfRowsInSection:)))
                    sut.expect(callTo: #selector(sut.tableView(_:cellForRowAt:)))
                    
                    //Act
                    _ = sut.tableView(tableView, numberOfRowsInSection: 0)
                    _ = sut.tableView(tableView, cellForRowAt: IndexPath())
                    
                    //Assert
                    verify(sut)
                }
                
                it("provids the correct value") {
                    //Arrange
                    sut.given(#selector(sut.tableView(_:numberOfRowsInSection:)), withArgumentsThatMatch: { (args) -> (Bool) in
                        return (args as! (UITableView, Int)).1 == 2
                    }, willReturn: 42)
                    
                    //Act
                    _ = sut.tableView(tableView, numberOfRowsInSection: 0)
                    _ = sut.tableView(tableView, cellForRowAt: IndexPath())
                    
                    //Assert
                    expect(sut.tableView(UITableView(), numberOfRowsInSection: 2)).to(equal(42))
                    expect(sut.tableView(UITableView(), numberOfRowsInSection: 1)).notTo(equal(42))
                }
            })
        }
    }
}
