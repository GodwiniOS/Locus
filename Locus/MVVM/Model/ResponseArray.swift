//
//  ResponseArray.swift
//  Locus
//
//  Created by Godwin A on 05/09/22.
//

import Foundation

struct ResponseBase : Codable {
    let dataset : [Dataset]?

    enum CodingKeys: String, CodingKey {

        case dataset = "dataset"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dataset = try values.decodeIfPresent([Dataset].self, forKey: .dataset)
    }
}
