//
//  DynamicTextView.swift
//  NotesApp
//
//  Created by Nadiia KUCHYNA on 5/10/19.
//  Copyright © 2019 Nadiia KUCHYNA. All rights reserved.
//

import UIKit

class DynamicTextView: UITextView, UITextViewDelegate {

    required init(coder: NSCoder) {
        super.init(coder: coder)!
        self.text = ""
        self.setPlaceholder()
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.tintColor = UIColor(red: 0.49, green: 0.17, blue: 0.2, alpha: 1)
    }
}

extension UITextView{
    
    func setPlaceholder() {
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Enter some text..."
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 42
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        self.addSubview(placeholderLabel)
    }
    
    func checkPlaceholder() {
        let placeholderLabel = self.viewWithTag(42) as! UILabel
        placeholderLabel.isHidden = !self.text.isEmpty
    }
    
    func disablePlaceholder() {
        let placeholderLabel = self.viewWithTag(42) as! UILabel
        placeholderLabel.isHidden = true
    }
}
