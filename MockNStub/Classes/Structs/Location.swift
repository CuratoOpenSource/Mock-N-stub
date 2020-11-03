//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

public struct Location {
    public let file: StaticString
    public let line: UInt
    
    public init(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }
}
