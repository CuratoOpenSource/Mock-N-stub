//
//  Copyright © 2020 Curato Research BV. All rights reserved.
//

import Foundation

/// Converts the input function to a function that always returns true
/// - Parameter input: input function that returns Void
func returningTrue<T>(_ input: @escaping (T)->Void) -> (T)->Bool {
    { args in
        input(args)
        return true
    }
}
