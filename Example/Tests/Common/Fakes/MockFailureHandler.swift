//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

import Foundation
import MockNStub

class MockFailureHandler: Mocking, FailingWithMessageAtLocation {
    
    func fail(with message: String, at location: Location) {
        didCallFunction(withID: .failWithMessageAtLocation, withArguments: message, location)
    }
}

extension MockFailureHandler: DefiningFunctionID {
    
    typealias FunctionID = FID
    
    enum FID: String {
        case failWithMessageAtLocation
    }
}
