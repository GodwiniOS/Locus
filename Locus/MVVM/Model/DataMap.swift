//
//  ViewController.swift
//  Locus
//
//  Created by Godwin A on 05/09/22.
//

import Foundation
struct DataMap : Codable {
    let options : [String]?

    enum CodingKeys: String, CodingKey {

        case options = "options"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        options = try values.decodeIfPresent([String].self, forKey: .options)
    }
}
