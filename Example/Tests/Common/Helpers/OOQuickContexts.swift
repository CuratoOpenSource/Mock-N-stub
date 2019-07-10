//
//  OOQuickContexts.swift
//  MockNStub_Example
//
//  Created by menno lovink on 10/07/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import MockNStub
import XCTest
import Quick

extension QuickSpec {
    
    class Context: CustomStringConvertible {
        
        typealias Closure = ()->()
        
        let description: String
        let beforeEach: Closure
        
        @discardableResult
        init(_ description: String,
             _ beforeEach: @escaping Closure) {
            self.description = description
            self.beforeEach = beforeEach
        }
        
        @discardableResult
        func subContext(_ description: String, _ beforeEach: @escaping Closure) -> SubContext {
            return SubContext(parent: self, description: description, beforeEach)
        }
        
        @discardableResult
        func when(_ description: String, _ beforeEach: @escaping Closure) -> SubContext {
            return subContext("When \(description)", beforeEach)
        }
        
        @discardableResult
        func andWhen(_ description: String, _ beforeEach: @escaping Closure) -> SubContext {
            return subContext("And When \(description)", beforeEach)
        }
        
        @discardableResult
        func then(_ description: String, _ expectations: @escaping Closure) -> Context {
            
            wrapInNeededContext {
                
                it("Then \(description)") {
                    self.performNeededBeforeEaches()
                    expectations()
                }
            }()
            
            return self
        }
        
        func performNeededBeforeEaches() {
            beforeEach()
        }
        
        func wrapInNeededContext(_ closure: @escaping Closure) -> Closure {
            return {
                context(self.description, {
                    closure()
                })
            }
        }
    }
    
    class Given: Context {
        
        init(a className: AnyClass, _ beforeEach: @escaping Closure) {
            super.init("Given a \(className)", beforeEach)
        }
    }
    
    class SubContext: Context {
        
        let parent: Context
        
        @discardableResult
        init(parent: Context,
             description: String,
             _ beforeEach: @escaping Closure) {
            self.parent = parent
            super.init(description, beforeEach)
        }
        
        override func performNeededBeforeEaches() {
            parent.performNeededBeforeEaches()
            beforeEach()
        }
        
        override func wrapInNeededContext(_ closure: @escaping QuickSpec.Context.Closure) -> QuickSpec.Context.Closure {
            return super.wrapInNeededContext {
                closure()
            }
        }
    }
}
