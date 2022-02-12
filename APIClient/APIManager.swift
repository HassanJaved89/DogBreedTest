//
//  APIManager.swift
//  DogBreedTest
//
//  Created by Hassan Javed on 10/02/2022.
//

import Foundation

class APIManager {
    
    func getAllBreeds(completionHandler: @escaping (BreedModel) -> ()) {
        var request = URLRequest(url: URL(string: "https://dog.ceo/api/breeds/list/all")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let breedModel: BreedModel = self.load(data: data!)
                completionHandler(breedModel)
            }
        })

        task.resume()
    }
    
    func getSpecificBreedImages(breedName: String, completionHandler: @escaping (BreedImages) -> ()) {
        var request = URLRequest(url: URL(string: "https://dog.ceo/api/breed/\(breedName.lowercased())/images")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let breedImages: BreedImages = self.load(data: data!)
                completionHandler(breedImages)
            }
        })

        task.resume()
    }
    
    func load<T: Decodable>(data: Data) -> T {
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        }
        catch {
            fatalError()
        }
    }
    
}
