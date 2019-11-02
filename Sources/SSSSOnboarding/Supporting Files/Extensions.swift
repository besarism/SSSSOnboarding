//
//  File.swift
//  
//
//  Created by Besar Ismaili on 02/11/2019.
//

import UIKit

extension UIView {
    public func removeAllConstraints() {
        var _superview = self.superview

        while let superview = _superview {
            for constraint in superview.constraints {

                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }

                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }

            _superview = superview.superview
        }

        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIFont {
    class func getFont(with fontName: String) -> UIFont {
        return UIFont(name: "\(fontName)-bold", size: 18) ?? UIFont.boldSystemFont(ofSize: 18)
    }
}
