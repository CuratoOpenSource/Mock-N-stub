//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

import Foundation
import MockNStub

class MockContainingFullnameAndOptionalNicknameUsingFunctions: Mocking, ContainingFullName, ContainingOptionalNickname {
    
    var fullName: String {
        get {
            return didCallFunction()
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

extension MockContainingFullnameAndOptionalNicknameUsingFunctions: DefiningFunctionID {
    typealias FunctionID = FuncID
    
    enum FuncID: String {
        case fullName
        case nickname
    }
}
