//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Eduard Meciar on 27/09/16.
//  Copyright © 2016 Eduard Meciar. All rights reserved.
//

import UIKit

class MameTableViewController : UITableViewController{
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MemeTableViewCell", forIndexPath: indexPath)
        let meme = memes[indexPath.row]
        
        // Set the name and image
        cell.textLabel?.text = meme.TopText
        
        cell.imageView?.image = meme.Image
        
        return cell
    }
    
    @IBAction func openMemeView(sender: AnyObject) {
        let memeController = storyboard?.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        
        presentViewController(memeController, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! DetailMemeViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    
}
