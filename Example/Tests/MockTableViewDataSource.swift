//
//  MockTableViewDataSource.swift
//  CanMock_Example
//
//  Created by Menno on 11/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import CanMock

class MockTableViewDataSource: NSObject, CanMock, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// This if statement is normally not need, it's implemented to support both method and selector verification
        if let numberOfRows: Int = didCall(with: (tableView, section)) {
            return numberOfRows
        } else {
            return didCall(#selector(tableView(_:numberOfRowsInSection:)), with: (tableView, section))!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tableViewCell: UITableViewCell = didCall(with: (tableView, indexPath)) {
            return tableViewCell
        } else {
            return didCall(#selector(tableView(_:cellForRowAt:)), with: (tableView, indexPath))!
        }
    }
}
