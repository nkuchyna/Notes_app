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
