//
//  SentmemeCollectionViewController.swift
//  MemeMe
//
//  Created by Eduard Meciar on 29/09/16.
//  Copyright © 2016 Eduard Meciar. All rights reserved.
//

import UIKit

class SentMemeColletionViewController: UICollectionViewController{
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBAction func openMemeView(sender: AnyObject) {
        let memeController = storyboard?.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        
        presentViewController(memeController, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let space: CGFloat = 3.0
        var dimension: CGFloat = 0.0
        //ckech device orientation
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)){
            dimension = (view.frame.size.width - (5 * space)) / 6.0
        }else{
           dimension = (view.frame.size.width - (2 * space)) / 3.0
        }
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView!.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! SentMemeCollectionViewCell
        let meme = memes[indexPath.item]
        let imageView = UIImageView(image: meme.MemedImage)
        cell.backgroundView = imageView
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! DetailMemeViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
