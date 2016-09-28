//
//  DetailMemeViewController.swift
//  MemeMe
//
//  Created by Eduard Meciar on 29/09/16.
//  Copyright © 2016 Eduard Meciar. All rights reserved.
//

import UIKit

class DetailMemeViewController : UIViewController{
    
    var meme: Meme?
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView!.image = meme!.MemedImage
        
    }

}
