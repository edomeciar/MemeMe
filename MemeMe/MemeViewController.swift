//
//  ViewController.swift
//  MemeMe
//
//  Created by Eduard Meciar on 02/03/16.
//  Copyright © 2016 Eduard Meciar. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{

    @IBOutlet weak var ImagePickerView: UIImageView!
    @IBOutlet weak var CameraButton: UIBarButtonItem!
    @IBOutlet weak var AlbumButton: UIBarButtonItem!
    
    @IBOutlet weak var TopTextField: UITextField!
    @IBOutlet weak var BottomTextFiled: UITextField!
    
    
    @IBOutlet weak var Toolbar: UIToolbar!
    
    @IBOutlet weak var NavBar: UIToolbar!
    
    @IBOutlet weak var ShareBarButtonItem: UIBarButtonItem!
    
    //Text Field Delegates Objects
    let topDelegate = TextFieldDelegate(pDefText: "TOP")
    let bottomDelegate = TextFieldDelegate(pDefText: "BOTTOM")
    
    var memeObject: Meme!
    
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextField(TopTextField, pText: "TOP", pDelegate: topDelegate)
        initTextField(BottomTextFiled, pText: "BOTTOM", pDelegate: bottomDelegate)
        ShareBarButtonItem.enabled = false
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func initTextField(pTextField: UITextField, pText: String, pDelegate: UITextFieldDelegate){
        pTextField.delegate = pDelegate
        pTextField.text = pText
        pTextField.defaultTextAttributes = memeTextAttributes
        pTextField.textAlignment = NSTextAlignment.Center
        pTextField.minimumFontSize = 40
        pTextField.adjustsFontSizeToFitWidth = false
    }
    
    func generateMemedImage() -> UIImage {
        Toolbar.hidden = true
        NavBar.hidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
    UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        Toolbar.hidden = false
        NavBar.hidden = false
        return memedImage
    }
    
    func save(generatedMemedImage: UIImage){
        memeObject = Meme.init(pTopText: "top", pBottomText: "bottom", pImage: ImagePickerView.image!, pMemedImage: generatedMemedImage)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(memeObject)
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification){
        if BottomTextFiled.isFirstResponder(){
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification){
        if BottomTextFiled.isFirstResponder(){
            self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) ->CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue //off CGRet
        return keyboardSize.CGRectValue().height
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
            ShareBarButtonItem.enabled = true
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("image picker did cancel")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func pickImageFromAlbum(chosenSource: UIImagePickerControllerSourceType) {
        let pickerControler = UIImagePickerController()
        pickerControler.delegate = self
        pickerControler.sourceType = chosenSource
        self.presentViewController(pickerControler, animated: true, completion: nil)
    }
    @IBAction func CancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func PickImageFromCamera(sender: AnyObject) {
        pickImageFromAlbum(.Camera)
    }

    @IBAction func PickImageFromAlbum(sender: AnyObject) {
        pickImageFromAlbum(.PhotoLibrary)
    }
    
   
    @IBAction func ShareAction(sender: AnyObject) {
        let generatedImage = generateMemedImage()
        let vc = UIActivityViewController(activityItems: [generatedImage], applicationActivities: [])
        presentViewController(vc, animated: true, completion: nil)
        vc.completionWithItemsHandler = {(activityType:String?, completed: Bool, returnedItems: [AnyObject]?, error: NSError?) in
            if completed {
                self.save(generatedImage)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
    }
}

