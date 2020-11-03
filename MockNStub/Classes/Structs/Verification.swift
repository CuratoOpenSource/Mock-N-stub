//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

import Foundation

public struct Verification {
    
    let methodID: MethodID
    let matcher: MatchingArguments
    let amount: Amount
    
    init(methodID: MethodID, matcher: MatchingArguments, amount: Amount = .anyAmount) {
        self.methodID = methodID
        self.matcher = matcher
        self.amount = amount
    }
}

extension Verification: CustomStringConvertible {
    
    public var description: String {
        var description = ""

        description.append(String(describing: methodID))
        description.append(" matcher: ")
        description.append(String(describing: matcher))
        
        return description
    }
}

public extension Verification {
    
    enum Amount {
        case anyAmount
        case exactly(amount: Int)
    }
}
