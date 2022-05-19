//
//  ListGameModel.swift
//  CommonLibHelperCapstone
//
//  Created by Phincon on 19/05/22.
//

import Foundation
import UIKit

public struct ListGameModel: Codable {
    public let results: [ListResultGame]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
public struct ListResultGame: Codable {
    let id: Int
    let name: String
    let rating: Double
    let backgroundImage: String
    let released : String

    enum CodingKeys: String, CodingKey {
        case id, name, released, rating
        case backgroundImage = "background_image"
    }
}
