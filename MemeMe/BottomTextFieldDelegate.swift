//
//  BottomTextFieldDelegate.swift
//  MemeMe
//
//  Created by Eduard Meciar on 04/03/16.
//  Copyright © 2016 Eduard Meciar. All rights reserved.
//

import Foundation
import UIKit

class BottomTextFiledDelegate: NSObject, UITextFieldDelegate{
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "BOTTOM"{
                textField.text = ""
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}