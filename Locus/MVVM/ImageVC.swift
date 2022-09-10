//
//  ImageVC.swift
//  Locus
//
//  Created by Godwin A on 10/09/22.
//
import UIKit

class ImageVC: UIViewController{

    // MARK: - Properties
    var imageView = UIImageView()
    var image: UIImage!
    // MARK: - Methods
    override func viewWillAppear(_ animated: Bool) {
        prepareView()
    }

    private func prepareView() {
        


        view.addSubview(imageView)
        imageView.prepareLayout(.top)
        imageView.prepareLayout(.bottom)
        imageView.prepareLayout(.leading)
        imageView.prepareLayout(.trailing)
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        
        }
}

