//
//  MockNamesContainerUsingMethods.swift
//  CanMock_Example
//
//  Created by Menno on 17/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import CanMock

class MockContainingFullnameAndOptionalNicknameUsingFunctions: Mocking, ContainingFullName, ContainingOptionalNickname {
    
    var fullName: String {
        get {
            return didCallFunction()!
        }
        set {
            didCallFunction(withArguments: newValue)
        }
    }
    
    var nickname: String? {
        get {
            return didCallFunction()
        }
        
        set {
            didCallFunction(withArguments: newValue)
        }
    }
}
