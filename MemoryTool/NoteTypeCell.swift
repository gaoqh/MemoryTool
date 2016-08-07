//
//  NoteTypeCell.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/8/6.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit

class NoteTypeCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!

    var model: Note? {
        didSet{
            if let value = model?.typeName{
                nameLabel.text = value.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
            }
            if let value = model?.typeOrder {
                 countLabel.text = value
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Theme.ColorCell
        nameLabel.font = APP_FONT(14)
        nameLabel.textColor = Theme.ColorCellText
        countLabel.font = APP_FONT(14)
        nameLabel.textColor = Theme.ColorCellDetail
    }


    
}
