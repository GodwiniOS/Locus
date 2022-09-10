//
//  JSONVC.swift
//  Locus
//
//  Created by Godwin A on 09/09/22.
//

import UIKit

class JSONVC: UIViewController{

    // MARK: - Properties
    var label = UILabel()
    var backGroundView = UIView()
    var text = "ERROR"
    
    // MARK: - Methods
    override func viewWillAppear(_ animated: Bool) {
        prepareView()
    }

    private func prepareView() {
        

        view.backgroundColor = .clear
        view.backgroundColor = .clear
        view.addSubview(backGroundView)

        backGroundView.prepareLayout(.leading,constant: 10)
        backGroundView.prepareLayout(.trailing,constant: -10)
        backGroundView.prepareLayout(.top,constant: 10)
        backGroundView.prepareLayout(.bottom,constant: -10)
        backGroundView.cornerRadius(color: .lightGray)
        

        backGroundView.addSubview(label)

        label.prepareLayout(.top)//topbarHeight())
        label.prepareLayout(.bottom)
        label.prepareLayout(.leading)
        label.prepareLayout(.trailing)
        label.text = text
        label.prepareTextField(size: .title)
        label.numberOfLines = 0
    }
}
