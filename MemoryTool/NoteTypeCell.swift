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
            nameLabel.text = model?.typeName
            countLabel.text = model?.typeOrder
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.font = APP_FONT(14)
        nameLabel.textColor = Theme.ColorCellText
        countLabel.font = APP_FONT(14)
        nameLabel.textColor = Theme.ColorCellDetail
    }


    
}
