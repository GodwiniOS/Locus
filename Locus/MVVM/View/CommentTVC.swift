//
//  OptionTVC.swift
//  Locus
//
//  Created by Godwin A on 07/09/22.
//

import UIKit


class CommentTableViewCell: UITableViewCell {

    let backGroundView = UIView()
    
    let commentView = UIView()
    let commentLabel = UILabel()
    let commentTextField = UITextField()
    var row:Int?
    var commentViewHeight: NSLayoutConstraint!
    
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
        commentTextField.delegate = self
        
        
        // prepare Title label
        backGroundView.addSubview(commentView)
        commentView.prepareLayout(.top,toItem: backGroundView,
                                 toAttribute: .top,constant: 8)
        commentView.prepareLayout(.leading,toItem: backGroundView,
                                 constant: 24)
        commentView.prepareLayout(.trailing,toItem: backGroundView,
                                 constant: -24)
        commentView.prepareLayout(.bottom,toItem: backGroundView,
                                  toAttribute: .bottom,constant: -24)
//        commentView.prepareHeight(constant: 40)
        commentView.backgroundColor = .white
        commentViewHeight = NSLayoutConstraint(
            item: commentView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 0)
        commentViewHeight.constant = 40
        
        contentView.addConstraint(commentViewHeight)

        
        commentView.prepareLayout(.bottom,toItem: backGroundView,
                             toAttribute: .top,constant: 8)
        
        backGroundView.addSubview(toggle)
        toggle.prepareLayout(.top,toItem: commentView,
                                 toAttribute: .top,constant: 8)
        toggle.prepareLayout(.trailing,toItem: backGroundView,
                                 constant: -24)
        toggle.addTarget(self, action: #selector(switchValueDidChange),
                         for: .valueChanged)
        
        
        
        backGroundView.addSubview(commentLabel)
        commentLabel.prepareLayout(.leading,toItem: commentView,
                                 toAttribute: .leading,constant: 8)
        commentLabel.prepareLayout(.top,toItem: commentView,
                             toAttribute: .top,constant: 8)
        commentLabel.prepareLayout(.trailing,toItem: toggle,
                                   toAttribute: .leading,constant: -8)
        commentLabel.prepareTextField(size: .title)
        commentLabel.prepareHeight(constant: 40)
        commentLabel.numberOfLines = 0
        commentLabel.text = "Provide Comment?"
        
        backGroundView.addSubview(commentTextField)
        commentTextField.prepareLayout(.leading,toItem: commentView,
                                 toAttribute: .leading,constant: 8)
        commentTextField.prepareLayout(.top,toItem: commentLabel,
                             toAttribute: .bottom,constant: 8)
        commentTextField.prepareLayout(.trailing,toItem: commentView,constant: -8)
        commentTextField.prepareLayout(.bottom,toItem: commentView,constant: -8)
        commentTextField.prepareTextField(size: .title)
        commentTextField.isHidden = true
        commentTextField.placeholder = "Type Comment"
    }
    
    
    func prepareTVC(title: String?,state: Bool?,row:Int,cmt:String){
//        commentLabel.text = title
        self.row = row
        contentView.removeConstraint(commentViewHeight)
        commentTextField.text = cmt

        commentViewHeight.constant = state ?? false ? 200 : 40
        contentView.addConstraint(commentViewHeight)
        commentTextField.isHidden = !(state ?? true)
        guard state != nil else { return }
        toggle.setOn(state!, animated: false)
    }
    
    
    @objc func switchValueDidChange(sender:UISwitch!) {
        commentTextField.isHidden = !sender.isOn
        delegate?.comment(state: sender.isOn,row: row ?? 0)
    }
}

extension CommentTableViewCell: UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate?.comment(text: textField.text ?? "", row: row!)
    }
}

