//
//  String+Localization.swift
//  Common
//
//  Created by Phincon on 22/09/21.
//

import Foundation

extension String {
  public func localized(identifier: String) -> String {
    let bundle = Bundle(identifier: identifier) ?? .main
    return bundle.localizedString(forKey: self, value: self, table: "Locazible")
  }
}
