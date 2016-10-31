//
//  SnapKit
//
//  Copyright (c) 2011-Present SnapKit Team - https://github.com/SnapKit
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif


public struct ConstraintViewDSL: ConstraintAttributesDSL {
    
    @discardableResult
    public func prepareConstraints(_ closure: (,_ make: ConstraintMaker) -> Void) -> [Constraint] {
        return ConstraintMaker.prepareConstraints(self.view, closure: closure)
    }
    
    public func makeConstraints(_ closure: (,_ make: ConstraintMaker) -> Void) {
        ConstraintMaker.makeConstraints(self.view, closure: closure)
    }
    
    public func remakeConstraints(_ closure: (,_ make: ConstraintMaker) -> Void) {
        ConstraintMaker.remakeConstraints(self.view, closure: closure)
    }
    
    public func updateConstraints(_ closure: (,_ make: ConstraintMaker) -> Void) {
        ConstraintMaker.updateConstraints(self.view, closure: closure)
    }
    
    public func removeConstraints() {
        ConstraintMaker.removeConstraints(self.view)
    }
    
    
    
    public var contentHuggingHorizontalPriority: Float {
        get {
            return self.view.contentHuggingPriority(for: .horizontal)
        }
        set {
            self.view.setContentHuggingPriority(newValue, forAxis: .horizontal)
        }
    }
    
    public var contentHuggingVerticalPriority: Float {
        get {
            return self.view.contentHuggingPriority(for: .vertical)
        }
        set {
            self.view.setContentHuggingPriority(newValue, forAxis: .vertical)
        }
    }
    
    public var contentCompressionResistanceHorizontalPriority: Float {
        get {
            return self.view.contentCompressionResistancePriority(for: .horizontal)
        }
        set {
            self.view.setContentHuggingPriority(newValue, forAxis: .horizontal)
        }
    }
    
    public var contentCompressionResistanceVerticalPriority: Float {
        get {
            return self.view.contentCompressionResistancePriority(for: .vertical)
        }
        set {
            self.view.setContentCompressionResistancePriority(newValue, forAxis: .vertical)
        }
    }
    
    public var target: AnyObject? {
        return self.view
    }
    
    internal let view: ConstraintView
    
    internal init(view: ConstraintView) {
        self.view = view
        
    }
    
    internal var layoutConstraints: [LayoutConstraint] {
        return self.layoutConstraintsHashTable.allObjects
    }
    
    internal func add(layoutConstraints: [LayoutConstraint]) {
        let hashTable = self.layoutConstraintsHashTable
        for layoutConstraint in layoutConstraints {
            hashTable.add(layoutConstraint)
        }
    }
    
    internal func remove(layoutConstraints: [LayoutConstraint]) {
        let hashTable = self.layoutConstraintsHashTable
        for layoutConstraint in layoutConstraints {
            hashTable.remove(layoutConstraint)
        }
    }
    
    private var layoutConstraintsHashTable: NSHashTable {
        let layoutConstraints: NSHashTable
        
        if let existing = objc_getAssociatedObject(self.view, &layoutConstraintsKey) as? NSHashTable {
            layoutConstraints = existing
        } else {
            layoutConstraints = NSHashTable.weakObjects()
            objc_setAssociatedObject(self.view, &layoutConstraintsKey, layoutConstraints, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return layoutConstraints
        
    }
    
}
private var layoutConstraintsKey: UInt8 = 0
