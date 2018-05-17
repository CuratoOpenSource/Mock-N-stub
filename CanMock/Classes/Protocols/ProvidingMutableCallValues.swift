public protocol ProvidingMutableCallValues: class {
    
    var callValues: [CallValue] { get set }
}

public extension ProvidingMutableCallValues {
    
    var callValues: [CallValue] {
        get {
            if let callValues = objc_getAssociatedObject(self, &AsociatedKeys.callValues) as? [CallValue] {
                return callValues
            } else {
                let callValues = [CallValue]()
                objc_setAssociatedObject(self, &AsociatedKeys.callValues, callValues, .OBJC_ASSOCIATION_RETAIN)
                return callValues
            }
        }
        set {
            objc_setAssociatedObject(self, &AsociatedKeys.callValues, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
