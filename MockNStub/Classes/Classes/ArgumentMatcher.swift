//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

public class ArgumentMatcher<ArgumentsType> {
    
    private let matcher: (ArgumentsType) -> Bool
    
    public init(matcher: @escaping (ArgumentsType) -> Bool) {
        self.matcher = matcher
    }
}

public extension ArgumentMatcher {
    
    /// Matches any argument
    static var any: ArgumentMatcher<Any> {
        return anyArgumentMatcher
    }
}

extension ArgumentMatcher: MatchingArguments {
    
    public func match(arguments: Any) -> Bool {
        guard let argumentsOfExpectedType = arguments as? ArgumentsType else {
            logger.logInfo("Matching failed for arguments \(arguments) of type \(type(of: arguments)) because they were not of expected type: \(ArgumentsType.self)")
            return false
        }
        return matcher(argumentsOfExpectedType)
    }
}


