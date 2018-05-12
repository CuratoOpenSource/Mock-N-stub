public class CallRegistry {
    
    internal private(set) var calls = [Call]()
    
    public init(){}
}

//MARK: Public methods
public extension CallRegistry {
    
    func didCallSelector(_ selector: Selector) {
        didCallSelector(selector, with: ())
    }
    
    func didCallFunction(_ function: String = #function) {
        didCallFunction(function, with: ())
    }
    
    func didCallSelector(_ selector: Selector, with arguments: Any) {
        calls.append(Call(selector: selector, arguments: arguments))
    }
    
    func didCallFunction(_ function: String = #function, with arguments: Any) {
        calls.append(Call(function: function, arguments: arguments))
    }
}
