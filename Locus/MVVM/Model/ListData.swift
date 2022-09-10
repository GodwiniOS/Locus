//
//  ViewController.swift
//  Locus
//
//  Created by Godwin A on 05/09/22.
//

import Foundation
struct Dataset : Codable {
    let type : String?
    let id : String?
    let title : String?
    let dataMap : DataMap?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case id = "id"
        case title = "title"
        case dataMap = "dataMap"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        dataMap = try values.decodeIfPresent(DataMap.self, forKey: .dataMap)
    }

}
