//
//  Mock.swift
//  CanMock_Example
//
//  Created by Menno on 11/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import CanMock

class MockFailureHandler: CanMock, CanFailWithMessageAtLocation {
    
    let callRegistry = CallRegistry()
    var callValues = [CallValue]()
    var calls = [Call]()
    var verifications = [Verification]()
    var selectorValues = [CallValue]()
    
    func fail(with message: String, at location: Location) {
        callRegistry.didCallFunction(with: (message, location))
    }
}
