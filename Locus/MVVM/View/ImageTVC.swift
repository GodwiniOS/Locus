//
//  LocusListVC.swift
//  Locusz
//
//  Created by Godwin  on 14/01/21.
//


import UIKit

protocol TableViewCellDelegate{
    func reload()
    func removePic(index:Int)
    func imageClick(index:Int)
    func comment(state: Bool,row:Int)
    func optionClicked(option: Int,row:Int)
    func comment(text: String,row:Int)
    func imageClickedToOpen(image:UIImage)
}

class ImageTableViewCell: UITableViewCell {

    let backGroundView = UIView()
    let commentView = UIView()
    
    let commentLabel = UILabel()
    let titleLabel = UILabel()
    
    let cameraImage = UIImageView()
    let remove = UIImageView()
    
    var image:UIImage?
    
    var commentViewHeight: NSLayoutConstraint!
    var index:Int!
    let toggle = UISwitch()
    var delegate: TableViewCellDelegate?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareTableViewCell() {
        

        // prepare Background
        backgroundColor = .clear
        selectionStyle = .none
        contentView.backgroundColor = .clear
        contentView.superview?.backgroundColor = .clear
        contentView.addSubview(backGroundView)

        backGroundView.prepareLayout(.leading,constant: 10)
        backGroundView.prepareLayout(.trailing,constant: -10)
        backGroundView.prepareLayout(.top,constant: 10)
        backGroundView.prepareLayout(.bottom,constant: -10)
        backGroundView.cornerRadius(color: .lightGray)

        // prepare Title label
        backGroundView.addSubview(titleLabel)
        titleLabel.prepareLayout(.top,toItem: backGroundView,
                                 constant: 16)
        titleLabel.prepareLayout(.leading,toItem: backGroundView,
                                 constant: 16)
        titleLabel.prepareLayout(.trailing,toItem: backGroundView,
                                 constant: -16)
        titleLabel.prepareHeight(constant: 20)
        titleLabel.prepareTextField(size: .title)
        titleLabel.numberOfLines = 0
        titleLabel.text = "hghgjh"
        
        // prepare completedButton
        backGroundView.addSubview(cameraImage)
        cameraImage.prepareLayout(.leading,constant: 15)
        cameraImage.prepareLayout(.top,toItem: titleLabel,
                                       toAttribute: .bottom,constant: 15)
        cameraImage.prepareLayout(.trailing,toItem: titleLabel,
                                       constant: -15)
        cameraImage.prepareLayout(.bottom,toItem: backGroundView,
                                       toAttribute: .bottom,
                                       constant: -15)
        cameraImage.image = UIImage(named: "Camera")

        cameraImage.prepareHeight(constant: 180)
//        cameraImage.backgroundColor = .red
        cameraImage.clipsToBounds = true
        cameraImage.contentMode = .scaleAspectFit
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(imageTapped(tapGestureRecognizer:)))
        cameraImage.isUserInteractionEnabled = true
        cameraImage.addGestureRecognizer(tapGestureRecognizer)
        
        // prepare completedButton
        backGroundView.addSubview(remove)
        remove.prepareLayout(.top,toItem: cameraImage,
                                       toAttribute: .top,constant: -15)
        remove.prepareLayout(.trailing,toItem: cameraImage,
                                       toAttribute: .trailing,constant: 15)
        remove.prepareHeight(constant: 30)
        remove.prepareWidth(constant: 30)
        remove.backgroundColor = .white
        remove.contentMode = .scaleAspectFill
        remove.clipsToBounds = true
        remove.image = UIImage(named: "Close")
        
        let tapGestureRemove = UITapGestureRecognizer(target: self,
                                                          action: #selector(removeTapped(tapGestureRecognizer:)))
        remove.isUserInteractionEnabled = true
        remove.addGestureRecognizer(tapGestureRemove)
    }

    
    @objc func imageTapped(tapGestureRecognizer: UIGestureRecognizer){
        if let img = image{
            delegate?.imageClickedToOpen(image: img)
        } else {
            delegate?.imageClick(index: index)

        }
    }
    
    @objc func removeTapped(tapGestureRecognizer: UIGestureRecognizer){
        delegate?.removePic(index: index)
    }
    
    func prepareTVC(image:UIImage? = nil,title: String?,index: Int){
        self.index = index
        self.image = image
        titleLabel.text = title
        if let img = image {
            remove.isHidden = false
            cameraImage.image = img
        } else {
            cameraImage.image = UIImage(named: "Camera")
            remove.isHidden = true
        }
    }
}
