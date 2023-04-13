//
//  ResponseModels.swift
//  TestOpenLibrary
//
//  Created by Александр Молчан on 13.04.23.
//

import Foundation

struct ResponseData: Decodable {
    var docs: [BookObject]
    
    enum CodingKeys: String, CodingKey {
        case docs = "docs"
    }

}

struct BookObject: Decodable {
    var name: String
    var firstPublishYear: Int
    var rate: Double?
    var snippet : [String]?
    var imageId: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case firstPublishYear = "first_publish_year"
        case rate = "ratings_average"
        case snippet = "first_sentence"
        case imageId = "cover_i"
    }
}

