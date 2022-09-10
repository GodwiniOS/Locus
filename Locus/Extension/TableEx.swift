//
//  ContentListVC.swift
//  Locusz
//
//  Created by Godwin  on 14/01/21.
//


import UIKit

extension UITableView {

    func registerCell() {
        self.register(ImageTableViewCell.self, forCellReuseIdentifier: "ImageTableViewCell")
        self.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
        self.register(OptionTableViewCell.self, forCellReuseIdentifier: "OptionTableViewCell")
        
    }
}

