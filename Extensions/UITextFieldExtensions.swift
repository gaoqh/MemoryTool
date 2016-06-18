//
//  UITextFieldExtensions.swift
//  DiamondClient
//
//  Created by gaoqinghua on 16/1/7.
//  Copyright © 2016年 hiersun. All rights reserved.
//

import Foundation
import UIKit

enum UITextFieldLeftViewMode: Int{
    case None = 0
    case Star
    case Space
}

extension UITextField: UITextFieldDelegate{
    func setLeftViewMode(mode:UITextFieldLeftViewMode) {
        
        font = UIFont.systemFontOfSize(14)
        textColor = UIColor.grayColor()
        self.autocorrectionType = .No
        clearButtonMode = UITextFieldViewMode.WhileEditing
        
        switch mode{
        case .Star:
            setStarView()
            break
        case .Space:
            setSpaceView()
            break
        default:
            break
        }
    }
    
    private func setStarView(){
        let leftV = UIView(frame: CGRectMake(0, 0, 10, frame.height))
        let leftImageView = UIImageView(image: UIImage(named: "mustNeed"))
        leftImageView.centerY = leftV.height * 0.5
        leftV.addSubview(leftImageView)
        self.leftView = leftV
        leftViewMode = UITextFieldViewMode.Always
    }
    
    private func setSpaceView(){
        let leftV = UIView(frame: CGRectMake(0, 0, 10, frame.height))
        self.leftView = leftV
        leftViewMode = UITextFieldViewMode.Always
    }
}