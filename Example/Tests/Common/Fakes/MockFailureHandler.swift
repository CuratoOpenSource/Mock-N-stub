//
//  Mock.swift
//  MockNStub_Example
//
//  Created by Menno on 11/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import MockNStub

class MockFailureHandler: Mocking, FailingWithMessageAtLocation {
    
    func fail(with message: String, at location: Location) {
        didCallFunction(withArguments: (message, location))
    }
}
