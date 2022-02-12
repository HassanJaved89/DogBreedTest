//
//  BreedsViewModel.swift
//  DogBreedTest
//
//  Created by Hassan Javed on 11/02/2022.
//

import Foundation

class BreedsViewModel {
    var breedsModel: BreedModel?
    var breedImages: BreedImages?
    var keysArray: [String] = []
    var selectedBreedKey = ""
}

// MARK:- Methods for Breeds VC
extension BreedsViewModel {
    func onLoad(completionHandler: @escaping (Bool) -> ()) {
        APIManager().getAllBreeds { breedsModel in
            self.breedsModel = breedsModel
            self.keysArray = [String]((self.breedsModel?.breeds.keys)!)
            completionHandler(true)
        }
    }
    
    func getSections() -> Int {
        return 1
    }
    
    func getNumberOfRows() -> Int {
        return self.keysArray.count
    }
    
    func getRowTitle(index: Int) -> String {
        let key = self.keysArray[index]
        return key
    }
    
    func rowSelected(index: Int) {
        let key = self.keysArray[index]
        self.selectedBreedKey = key
    }
}


//MARK:- Methods for Dogs VC
extension BreedsViewModel {
    
    func onLoadInnerVC(completionHandler: @escaping (Bool) -> ()) {
        APIManager().getSpecificBreedImages(breedName: self.selectedBreedKey) { breedImages in
            self.breedImages = breedImages
            completionHandler(true)
        }
    }
    
    func getNumberOfItems() -> Int {
        return self.breedImages?.images.count ?? 0
    }
    
    func getImage(index: Int) -> String {
        return self.breedImages?.images[index] ?? ""
    }
}
