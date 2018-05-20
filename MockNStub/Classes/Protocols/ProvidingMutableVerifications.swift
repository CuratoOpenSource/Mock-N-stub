public protocol ProvidingMutableVerifications: class {
    
    var verifications: [Verification] { get set }
}

public extension ProvidingMutableVerifications {
    
    var verifications: [Verification] {
        get {
            if let verifications = objc_getAssociatedObject(self, &AsociatedKeys.verifications) as? [Verification] {
                return verifications
            } else {
                let verifications = [Verification]()
                objc_setAssociatedObject(self, &AsociatedKeys.verifications, verifications, .OBJC_ASSOCIATION_RETAIN)
                return verifications
            }
        }
        set {
            objc_setAssociatedObject(self, &AsociatedKeys.verifications, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
