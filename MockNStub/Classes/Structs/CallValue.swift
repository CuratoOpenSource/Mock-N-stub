//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

public struct CallValue {
    
    public let methodID: MethodID
    public let value: Any?
    public let matcher: MatchingArguments
}

extension CallValue: CustomStringConvertible {
    
    public var description: String {
        var description = ""
        
        description.append(String(describing: methodID))
        description.append(" value: ")
        description.append(String(describing: value ?? "nil"))
        description.append(" matcher: ")
        description.append(String(describing: matcher))
        
        return description
    }
}
