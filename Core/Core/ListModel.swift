//
//  ListModel.swift
//  Core
//
//  Created by Phincon on 22/09/21.
//

import Foundation

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
