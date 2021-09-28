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

extension UIViewController{
    public func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int?) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}

extension Double {
   public func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

//extension UIViewController{
//    public func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int?) -> Void) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        for (index, option) in options.enumerated() {
//            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
//                completion(index)
//            }))
//        }
//        self.present(alertController, animated: true, completion: nil)
//    }
//}
