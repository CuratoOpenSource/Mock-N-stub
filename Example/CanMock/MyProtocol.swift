//
//  MyProtocol.swift
//  CanMock_Example
//
//  Created by Menno on 05/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import CanMock

protocol MyProtocol {
    
    func doThis()
    func doThat()
    func say(name: String)
    func say(greeting: String, to person: String, with age: UInt)
}
