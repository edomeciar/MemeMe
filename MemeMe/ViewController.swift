//
//  ViewController.swift
//  MemeMe
//
//  Created by Eduard Meciar on 02/03/16.
//  Copyright © 2016 Eduard Meciar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{

    @IBOutlet weak var ImagePickerView: UIImageView!
    @IBOutlet weak var CameraButton: UIBarButtonItem!
    @IBOutlet weak var AlbumButton: UIBarButtonItem!
    
    @IBOutlet weak var TopTextField: UITextField!
    @IBOutlet weak var BottomTextFiled: UITextField!
    
    var memedImage: UIImage
    
    //Text Field Delegates Objects
    let topDelegate = TopTextFieldDelegate()
    let bottomDelegate = BottomTextFiledDelegate()
    
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : 4
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TopTextField.delegate = topDelegate
        TopTextField.text = "TOP"
        TopTextField.defaultTextAttributes = memeTextAttributes
        TopTextField.textAlignment = NSTextAlignment.Center
        BottomTextFiled.delegate = bottomDelegate
        BottomTextFiled.text = "BOTTOM"
        BottomTextFiled.defaultTextAttributes = memeTextAttributes
        BottomTextFiled.textAlignment = NSTextAlignment.Center
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        CameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotification()
    }
    
    func subscribeToKeyboardNotifications(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification){
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification){
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) ->CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue //off CGRet
        return keyboardSize.CGRectValue().height
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]){
            print("image has been selected")
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
                print("image selected")
                ImagePickerView.image = image
            }else{
                print("NOT selected")
            }
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("image picker did cancel")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func PickImageFromCamera(sender: AnyObject) {
        let pickerControler = UIImagePickerController()
        pickerControler.delegate = self
        pickerControler.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(pickerControler, animated: true, completion: nil)
        print("PICK Camera")
    }

    @IBAction func PickImageFromAlbum(sender: AnyObject) {
        let pickerControler = UIImagePickerController()
        pickerControler.delegate = self
        pickerControler.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerControler, animated: true, completion: nil)
        print("PICK Album")
    }
    
    func save() {
        //Create the meme
        
    }
    
    

}

