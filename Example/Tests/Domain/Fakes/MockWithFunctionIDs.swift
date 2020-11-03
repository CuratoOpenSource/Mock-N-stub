//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

import Foundation
import MockNStub

class MockWithFunctionIDs: Mocking {
    
    func doThis() {
        didCallFunction(withID: .doThis)
    }
    
    func doThat(with booleanArgument: Bool) {
        didCallFunction(withID: .doThatWithBooleanArgument, withArguments: booleanArgument)
    }
}

extension MockWithFunctionIDs: DefiningFunctionID {
    typealias FunctionID = FuncID
    
    enum FuncID: String {
        case doThis
        case doThatWithBooleanArgument
    }
}
