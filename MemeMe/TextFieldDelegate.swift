//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by Eduard Meciar on 13/07/16.
//  Copyright © 2016 Eduard Meciar. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var Deftext = ""
    
    init(pDefText: String){
        Deftext = pDefText
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == Deftext{
            textField.text = ""
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}