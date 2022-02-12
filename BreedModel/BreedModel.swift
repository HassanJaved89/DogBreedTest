//
//  BreedModel.swift
//  DogBreedTest
//
//  Created by Hassan Javed on 10/02/2022.
//

import Foundation

class BreedModel: Codable {
    var breeds: [String: [String]]
    
    private enum CodingKeys : String, CodingKey {
        case breeds = "message"
    }
}

struct BreedImages: Codable {
    var images: [String]
    
    private enum CodingKeys : String, CodingKey {
        case images = "message"
    }
}
