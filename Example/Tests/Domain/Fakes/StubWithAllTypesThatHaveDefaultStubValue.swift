//
//  MockWithDefaultStubValues.swift
//  MockNStub_Example
//
//  Created by Menno on 19/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import MockNStub

class StubWithAllTypesThatHaveDefaultStubValue: Stubbing {
    
    // MARK: String
    func stringUsingFunction() -> String {
        return didCallFunction()!
    }
    
    @objc func stringUsingSelector() -> String {
        return didCallSelector(#selector(stringUsingSelector))!
    }
}
