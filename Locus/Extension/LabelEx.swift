//
//  ContentListVC.swift
//  Locusz
//
//  Created by Godwin  on 14/01/21.
//

import UIKit


extension UILabel{

    func prepareTextField(size: FontSize) {
        font = font.withSize(size.rawValue)
        textColor = .black
    }
}


extension UITextField{

    func prepareTextField(size: FontSize) {
        font = font?.withSize(size.rawValue)
        textColor = .black
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor

    }
}

enum FontSize: CGFloat {
    
    case title = 16
    case subtite = 10
}
