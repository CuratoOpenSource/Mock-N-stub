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

    var selectorValues = [SelectorValue]()
    var verifications: [Verification] = [Verification]()
    var calls: [Call] = [Call]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        didCall(#selector(tableView(_:numberOfRowsInSection:)), with: (tableView, section))
        return value(for: #selector(tableView(_:numberOfRowsInSection:)), with: (tableView, section)) as? Int ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        didCall(#selector(tableView(_:cellForRowAt:)), with: (tableView, indexPath))
        return value(for: #selector(tableView(_:cellForRowAt:)), with: (indexPath)) as? UITableViewCell ?? UITableViewCell()
    }
}
