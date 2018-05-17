public protocol ProvidingMutableCalls: class {
    
    var calls: [Call] { get set }
}

public extension ProvidingMutableCalls {
    
    var calls: [Call] {
        get {
            if let calls = objc_getAssociatedObject(self, &AsociatedKeys.calls) as? [Call] {
                return calls
            } else {
                let calls = [Call]()
                objc_setAssociatedObject(self, &AsociatedKeys.calls, calls, .OBJC_ASSOCIATION_RETAIN)
                return calls
            }
        }
        set {
            objc_setAssociatedObject(self, &AsociatedKeys.calls, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
