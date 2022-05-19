//
//  Extension.swift
//  Common
//
//  Created by Phincon on 23/09/21.
//

import Foundation
import UIKit
import RxCocoa

extension UIView {
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension BehaviorRelay where Element: RangeReplaceableCollection {

    public func add(element: Element.Element) {
        var array = self.value
        array.append(element)
        self.accept(array)
    }
}
