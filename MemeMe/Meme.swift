//
//  Meme.swift
//  MemeMe
//
//  Created by Eduard Meciar on 17/03/16.
//  Copyright © 2016 Eduard Meciar. All rights reserved.
//

import Foundation
import UIKit

class Meme: NSObject{
    
    var TopText: String = ""
    var BottomText: String = ""
    var Image: UIImage!
    var MemedImage: UIImage! = nil
    
    init(pTopText: String, pBottomText: String, pImage: UIImage, pMemedImage: UIImage) {
        TopText = pTopText
        BottomText = pBottomText
        Image = pImage
        MemedImage = pMemedImage
    }
    
}
