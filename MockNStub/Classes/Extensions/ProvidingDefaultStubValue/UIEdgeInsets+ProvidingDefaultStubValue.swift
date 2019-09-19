import UIKit

extension UIEdgeInsets: ProvidingDefaultStubValue {
    
    public static func defaultStubValue() -> UIEdgeInsets {
        return .zero
    }
}
