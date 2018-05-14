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

    var callValues = [CallValue]()
    var calls = [Call]()
    var verifications = [Verification]()
    
    var failureHandler: CanFailWithMessageAtLocation {
        return didCall()!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return didCall(#selector(tableView(_:numberOfRowsInSection:)), with: (tableView, section))!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return didCall(#selector(tableView(_:cellForRowAt:)), with: (tableView, indexPath))!
    }
}
