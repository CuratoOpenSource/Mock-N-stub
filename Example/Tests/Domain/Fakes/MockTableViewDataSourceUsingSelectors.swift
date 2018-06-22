//
//  MockTableViewDataSource.swift
//  MockNStub_Example
//
//  Created by Menno on 11/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import MockNStub

class MockTableViewDataSourceUsingSelectors: NSObject, Mocking, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return didCallSelector(#selector(tableView(_:numberOfRowsInSection:)), withArguments: tableView, section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return didCallSelector(#selector(tableView(_:cellForRowAt:)), withArguments: tableView, indexPath)
    }
}
