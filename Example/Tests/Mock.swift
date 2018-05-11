//
//  Mock.swift
//  CanMock_Example
//
//  Created by Menno on 11/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import CanMock

class Mock: CanMock, MyProtocol {
    
    var verifications: [Verification] = [Verification]()
    var calls: [Call] = [Call]()
    
    @objc func doThis() {
        didCall(#selector(doThis))
    }
    
    @objc func doThat() {
        didCall(#selector(doThat))
    }
    
    @objc func say(name: String) {
        didCall(#selector(say(name:)), with: (name))
    }
    
    @objc func say(greeting: String, to person: String, with age: UInt) {
        didCall(#selector(say(greeting:to:with:)), with: (greeting, person, age))
    }
}
