//
//  SecondViewController.swift
//  DogBreedTest
//
//  Created by Hassan Javed on 11/02/2022.
//

import Foundation
import UIKit
import Kingfisher

class SecondViewController: UIViewController {
    var viewModel: BreedsViewModel?
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        self.title = viewModel?.selectedBreedKey
        
        viewModel?.onLoadInnerVC(completionHandler: { success in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
}

extension SecondViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getNumberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DogCellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogCell", for: indexPath) as? DogCellCollectionViewCell ?? DogCellCollectionViewCell()
        let url = URL(string: viewModel?.getImage(index: indexPath.row) ?? "")
        cell.imageView?.kf.setImage(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageVC: ImageViewController? = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController
        imageVC?.imageName = viewModel?.getImage(index: indexPath.row) ?? ""
        self.present(imageVC!, animated: false)
    }
}
