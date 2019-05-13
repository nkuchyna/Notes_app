//
//  GlobalConstants.swift
//  NotesApp
//
//  Created by Nadiia KUCHYNA on 09.05.19.
//  Copyright © 2019 Nadiia KUCHYNA. All rights reserved.
//

import UIKit

enum eState { case SHOW, EDIT, ADD }
enum eSortType{ case NAME_ACS, NAME_DESC, CRDATE_ASC, CRDATE_DESC, MODDATE_ASC, MODDATE_DESC}
let _gAlert = UIAlertController(title: "Error", message: "Error", preferredStyle: .alert)

extension String {
    func maxSize(size : Int) -> String {
        var str = self
        let nsStr = str as NSString
        if nsStr.length >= size {
            str = nsStr.substring(with: NSRange(location: 0, length: nsStr.length > size ? size : nsStr.length))
            str += "..."
        }
        return str
    }
}

func showAlertMessage(vc: UIViewController, titleStr:String, messageStr:String) -> Void {
    _gAlert.title = titleStr
    _gAlert.message = messageStr
    vc.present(_gAlert, animated: true)
}

extension UIView {
    func addBackground(image : UIImage) {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = image
        backgroundImageView.clipsToBounds = true
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.alpha = 0.1
        backgroundImageView.contentMode = .scaleAspectFill
        self.insertSubview(backgroundImageView, at: 0)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[backgroundImageView]|", options: [],
                                                           metrics: nil, views: ["backgroundImageView": backgroundImageView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[backgroundImageView]|", options: [],
                                                           metrics: nil, views: ["backgroundImageView": backgroundImageView]))
    }
}
