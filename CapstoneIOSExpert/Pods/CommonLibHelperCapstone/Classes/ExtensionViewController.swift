//
//  ExtensionViewController.swift
//  CommonLibHelperCapstone
//
//  Created by Phincon on 19/05/22.
//

import Foundation
import UIKit

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
