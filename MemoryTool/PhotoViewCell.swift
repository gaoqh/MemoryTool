//
//  PhotoViewCell.swift
//  MemoryTool
//
//  Created by 高庆华 on 16/7/10.
//  Copyright © 2016年 高庆华. All rights reserved.
//

import UIKit

class PhotoViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.contentMode = .ScaleAspectFill
        
    }

}
