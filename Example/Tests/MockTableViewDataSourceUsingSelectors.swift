//
//  MockTableViewDataSource.swift
//  CanMock_Example
//
//  Created by Menno on 11/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import CanMock

class MockTableViewDataSourceUsingSelectors: NSObject, CanMock, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return didCall(#selector(tableView(_:numberOfRowsInSection:)), with: (tableView, section))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return didCall(#selector(tableView(_:cellForRowAt:)), with: (tableView, indexPath))!
    }
}
