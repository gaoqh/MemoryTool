//
//  NoHighlightButton.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/6/16.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit

class NoHighlightButton: UIButton {

    /// 重写setFrame方法
    override var highlighted: Bool {
        didSet{
            super.highlighted = false
        }
    }

}
