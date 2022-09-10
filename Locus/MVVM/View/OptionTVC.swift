//
//  CommentTVC.swift
//  Locus
//
//  Created by Godwin A on 07/09/22.
//

import UIKit


class OptionTableViewCell: UITableViewCell {

    let backGroundView = UIView()
    
    let titleLabel = UILabel()
    var labelRadios = [UILabel]()
    var radioImages = [UIImageView]()
    var optionsString:[String] = []
    var row:Int!
    var delegate: TableViewCellDelegate?

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareTableViewCell(selectedIndex:Int?) {
        labelRadios.removeAll()
        radioImages.removeAll()
        for constraint in contentView.constraints{
            constraint.isActive = false
        }
        for view in contentView.subviews{
            view.removeFromSuperview()
        }
        
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
        
        
        for index in 0..<optionsString.count {
            let radioA = UIImageView()
            
            backGroundView.addSubview(radioA)
            radioA.prepareLayout(.leading,constant: 15)
            radioA.prepareLayout(.top,
                                 toItem: index == 0 ? titleLabel : labelRadios[index-1],
                                 toAttribute: .bottom,constant: 0)
            
            radioA.prepareHeight(constant: 40)
            radioA.prepareWidth(constant: 40)
            radioA.backgroundColor = .white
            radioA.contentMode = .scaleAspectFill
            radioA.clipsToBounds = true
            radioA.tag = index
            if let sIndex = selectedIndex,index == sIndex {
                radioA.image = UIImage(named: "RadioEnable")
            } else {
                radioA.image = UIImage(named: "RadioDisable")
            }

            let tapGestureRecognizerA = UITapGestureRecognizer(target: self,
                                                              action: #selector(radioClick(tapGestureRecognizer:)))
            radioA.isUserInteractionEnabled = true
            radioA.addGestureRecognizer(tapGestureRecognizerA)
            radioImages.append(radioA)
            
            let labelA = UILabel()
            backGroundView.addSubview(labelA)
            labelA.prepareLayout(.top,toItem: radioA)
            labelA.prepareLayout(.leading,toItem: radioA,
                                 toAttribute: .trailing,constant: 8)
            labelA.prepareLayout(.trailing,toItem: backGroundView,
                                     constant: -24)
            labelA.prepareHeight(constant: 40)
            labelA.prepareTextField(size: .title)
            labelA.numberOfLines = 0
            labelA.text = optionsString[index]
            labelRadios.append(labelA)
        }
        
        labelRadios[optionsString.count-1].prepareLayout(.bottom,constant: -8)
        radioImages[optionsString.count-1].prepareLayout(.bottom,constant: -8)
    }
    
    
    
 
    
    @objc func radioClick(tapGestureRecognizer: UIGestureRecognizer){
        if let index = tapGestureRecognizer.view?.tag{
            delegate?.optionClicked(option: index, row: row)
        }
    }
    
    func prepareTVC(title: String? = nil,
                    options: [String],selectedIndex:Int?,row:Int){
        self.row = row
        optionsString = options
        prepareTableViewCell(selectedIndex: selectedIndex)
        
        if let text = title {
            titleLabel.text = text
        }
    }
}
