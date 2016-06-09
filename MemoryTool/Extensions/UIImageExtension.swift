//图片压缩
//
//  Created by apple on 15/10/21.
//  Copyright © 2015年 apple. All rights reserved.
//

import Foundation
import UIKit


extension UIImage {
    
    
    func scale(width width: CGFloat) -> UIImage {
        
        //把高度计算出来-->通过宽度,按比例把高度计算出来
        
        //600 * 400
        //比如原图:600, 相缩放成宽度300
        //300 * 200
        let scaleHeight = width / size.width * size.height
        
        //缩放之后的size
        let scaleSize = CGSizeMake(width, scaleHeight)
        
        //开启
        UIGraphicsBeginImageContext(scaleSize)
        
        //把当前的内容完整的画到指定的大小上面去
        drawInRect(CGRect(origin: CGPointZero, size: scaleSize))
        
        //获取到你画出来东西
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        //关闭
        UIGraphicsEndImageContext()
        
        
        return result
        
    }
    
    
}