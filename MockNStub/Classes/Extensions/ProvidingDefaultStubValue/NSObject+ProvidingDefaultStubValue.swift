import UIKit

extension NSObject: ProvidingDefaultStubValue {
    
    @objc public static func defaultStubValue() -> Self {
        return self.init()
    }
}
