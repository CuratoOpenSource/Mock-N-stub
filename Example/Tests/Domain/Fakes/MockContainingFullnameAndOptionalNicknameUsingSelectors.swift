//
//  MockNamesContainerUsingMethods.swift
//  MockNStub_Example
//
//  Created by Menno on 17/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import MockNStub

class MockContainingFullnameAndOptionalNicknameUsingSelectors: Mocking, ContainingFullName, ContainingOptionalNickname {
    
    @objc var fullName: String {
        get {
            return didCallSelector(#selector(getter: self.fullName))!
        }
        set {
            didCallSelector(#selector(setter: fullName), withArguments: newValue)
        }
    }
    
    @objc var nickname: String? {
        get {
            return didCallSelector(#selector(getter: self.nickname))
        }
        set {
            didCallSelector(#selector(setter: nickname), withArguments: newValue)
        }
    }
}
