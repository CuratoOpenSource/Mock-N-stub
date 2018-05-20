public class ArgumentMatcher<ArgumentsType> {
    
    private let matcher: (ArgumentsType) -> Bool
    
    public init(matcher: @escaping (ArgumentsType) -> Bool) {
        self.matcher = matcher
    }
}

public extension ArgumentMatcher {
    
    /// Matches any argument
    public static var any: ArgumentMatcher<Any> {
        return anyArgumentMatcher
    }
}

extension ArgumentMatcher: MatchingArguments {
    
    public func match(arguments: Any) -> Bool {
        guard let arguments = arguments as? ArgumentsType else {
            return false
        }
        return matcher(arguments)
    }
}


