//
//  DetailGameModel.swift
//  Detail
//
//  Created by Phincon on 22/09/21.
//

import Foundation

struct DetailGameModel: Codable {
    let name: String?
    let backgroundImage: String?
    let rating: Double?
    let ratingsCount: Double?
    let achievementsCount: Int?
    let descriptionRaw: String?
    let released: String?

    enum CodingKeys: String, CodingKey {
        case name
        case backgroundImage = "background_image"
        case rating
        case ratingsCount = "ratings_count"
        case achievementsCount = "achievements_count"
        case descriptionRaw = "description_raw"
        case released = "released"
    }
}
