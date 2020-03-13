//
//  File.swift
//  
//
//  Created by menno on 13/03/2020.
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
