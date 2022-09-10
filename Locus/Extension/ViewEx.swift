//
//  ContentListVC.swift
//  Locusz
//
//  Created by Godwin  on 14/01/21.
//

import UIKit

extension UIView {
    
    
    func prepareLayout(_ attribute: NSLayoutConstraint.Attribute,
                       toItem :UIView? = nil,
                       toAttribute :NSLayoutConstraint.Attribute? = nil,
                       constant: CGFloat = 0) {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        let withItem: UIView! =  toItem != nil ? toItem! : superview
        let withAttribute: NSLayoutConstraint.Attribute! = toAttribute != nil ? toAttribute! : attribute

        let layout = NSLayoutConstraint(item: self,
                                        attribute: attribute,
                                        relatedBy: .equal,
                                        toItem: withItem,
                                        attribute: withAttribute,
                                        multiplier: 1,
                                        constant: constant)
        
        NSLayoutConstraint.activate([layout])
    }
    
//    func prepareLayoutView(_ attribute: NSLayoutConstraint.Attribute,
//                       toItem :UIView? = nil,
//                       toAttribute :NSLayoutConstraint.Attribute? = nil,
//                       constant: StaticSize = .noSpace) {
//
//        translatesAutoresizingMaskIntoConstraints = false
//        let withItem: UIView! =  toItem != nil ? toItem! : superview
//        let withAttribute: NSLayoutConstraint.Attribute! = toAttribute != nil ? toAttribute : attribute
//
//        let layout = NSLayoutConstraint(item: self,
//                                        attribute: attribute,
//                                        relatedBy: .equal,
//                                        toItem: withItem,
//                                        attribute: withAttribute,
//                                        multiplier: 1,
//                                        constant: constant.rawValue)
//
//        NSLayoutConstraint.activate([layout])
//    }
    
    
    func prepareLayoutsAll(_ attributes: [NSLayoutConstraint.Attribute] = [.top,.bottom,.leading,.trailing]) {
        
        
        translatesAutoresizingMaskIntoConstraints = false

        for attribute in attributes {
            let layout = NSLayoutConstraint(item: self,
                                            attribute: attribute,
                                            relatedBy: .equal,
                                            toItem: superview,
                                            attribute: attribute,
                                            multiplier: 1,
                                            constant: 0)
            
            NSLayoutConstraint.activate([layout])
        }

    }
    
    
    func prepareHeight(constant: CGFloat) {
        
//        frame = CGRect(x: frame.minX, y: frame.minX, width: frame.width, height: constant)
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: constant)

        NSLayoutConstraint.activate([constraint])
        
    }
    
    func prepareWidth(constant: CGFloat) {
        
//        frame = CGRect(x: frame.minX, y: frame.minX, width: frame.width, height: constant)
        
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: constant)

        NSLayoutConstraint.activate([constraint])
        
    }
    
    
    func cornerRadius(constant: CGFloat = 10,color: UIColor,
                      width: CGFloat = 1){
        layer.cornerRadius = constant;
        layer.masksToBounds = true;
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func borderView(constant: CGFloat = 10,color: UIColor,
                      width: CGFloat = 1){
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
