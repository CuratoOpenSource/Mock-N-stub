//
//  TableViewDataSource.swift
//  CanMock_Tests
//
//  Created by Menno on 16/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

/// Non objc version of UITableViewDataSource
protocol TableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}
