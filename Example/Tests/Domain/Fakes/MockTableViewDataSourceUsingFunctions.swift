//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

import Foundation
import MockNStub

class MockTableViewDataSourceUsingFunctions: NSObject, Mocking, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return didCallFunction(withArguments: tableView, section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return didCallFunction(withArguments: tableView, indexPath)
    }
    
    struct Function {
        static let tableView_NumberOfRowsInSection = "tableView(_:numberOfRowsInSection:)"
        static let tableView_CellForRowAtIndexPath = "tableView(_:cellForRowAt:)"
    }
}
