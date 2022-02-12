//
//  ImageViewController.swift
//  DogBreedTest
//
//  Created by Hassan Javed on 11/02/2022.
//

import UIKit
import Kingfisher

class ImageViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrolView: UIScrollView!
    var imageName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        scrolView.minimumZoomScale = 1.0
        scrolView.maximumZoomScale = 3.0
        scrolView.delegate = self
        
        let url = URL(string:imageName)
        imageView?.kf.setImage(with: url)
        
   }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = imageView.image {
                let ratioW = imageView.frame.width / image.size.width
                let ratioH = imageView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                var newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = (newWidth * scrollView.zoomScale) > imageView.frame.width
                newWidth = conditionLeft ? imageView.frame.width : scrollView.frame.width - scrollView.contentSize.width
                let left = 0.5 * newWidth
                let conditionTop = newHeight * scrollView.zoomScale > imageView.frame.height
                
                let top = 0.5 * (conditionTop ? newHeight - imageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                
            }
        }
        else {
            scrollView.contentInset = .zero
        }
    }

}
