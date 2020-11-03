//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

import XCTest

public struct XCTFailureHandler: FailingWithMessageAtLocation {
    
    public func fail(with message: String, at location: Location) {
        XCTFail(message, file: location.file, line: location.line)
    }
    
    public init() {}
}
