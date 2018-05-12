public class Matcher<ArgumentsType> {
    
    private let matcher: (ArgumentsType) -> Bool
    
    public init(matcher: @escaping (ArgumentsType) -> Bool) {
        self.matcher = matcher
    }
}

public extension Matcher {
    
    public static var any: Matcher<Any> {
        return Matcher<Any>(matcher: { (args) -> Bool in return true })
    }
}

extension Matcher: CanMatchArguments {
    
    public func match(arguments: Any) -> Bool {
        guard let arguments = arguments as? ArgumentsType else { return false }
        return matcher(arguments)
    }
}


