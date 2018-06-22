//
//  MockWithDefaultStubValues.swift
//  MockNStub_Example
//
//  Created by Menno on 19/06/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import MockNStub

class StubWithAllTypesThatHaveDefaultStubValue: Stubbing {
    
    // MARK: Standard types
    func stringUsingFunction() -> String {
        return didCallFunction()
    }
    
    @objc func stringUsingSelector() -> String {
        return didCallSelector(#selector(stringUsingSelector))
    }
    
    func array() -> [Bool] {
        return didCallFunction()
    }
    
    func dictionary() -> [String: [Bool]] {
        return didCallFunction()
    }
    
    func set() -> Set<Bool> {
        return didCallFunction()
    }
    
    func int() -> Int {
        return didCallFunction()
    }
    
    func bool() -> Bool {
        return didCallFunction()
    }
    
    func float() -> Float {
        return didCallFunction()
    }
    
    func double() -> Double {
        return didCallFunction()
    }
    
    // MARK: UIKit
    func color() -> UIColor {
        return didCallFunction()
    }
    
    func view() -> UIView {
        return didCallFunction()
    }
    
    func label() -> UILabel {
        return didCallFunction()
    }
    
    func button() -> UIButton {
        return didCallFunction()
    }
    
    func edgeInsets() -> UIEdgeInsets {
        return didCallFunction()
    }
    
    func viewController() -> UIViewController {
        return didCallFunction()
    }
    
    func navigationController() -> UINavigationController {
        return didCallFunction()
    }
    
    func tabbarController() -> UITabBarController {
        return didCallFunction()
    }
 
    func barButtonItem() -> UIBarButtonItem {
        return didCallFunction()
    }
    
    // MARK: CoreGraphics
    func cgFloat() -> CGFloat {
        return didCallFunction()
    }
    
    func cgSize() -> CGSize {
        return didCallFunction()
    }

    func cgPoint() -> CGPoint {
        return didCallFunction()
    }
    
    func cgRect() -> CGRect {
        return didCallFunction()
    }
    
    func cgAffineTransForm() -> CGAffineTransform {
        return didCallFunction()
    }
}
