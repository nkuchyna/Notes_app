//
//  NoteSortAlertController.swift
//  NotesApp
//
//  Created by Nadiia KUCHYNA on 5/11/19.
//  Copyright © 2019 Nadiia KUCHYNA. All rights reserved.
//

import UIKit

class NoteSortAlertController: UIAlertController {

    var delegate: NoteSortAlertControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.message = "Please, choose a sort type"
        self.addAction(UIAlertAction(title: "(a..z) alphabetical order ", style: .default, handler: {
            (action) -> Void in
            DataManager.shared.setSortType(type: eSortType.NAME_ACS)
            DataManager.shared.sortAllNotes(sortType: eSortType.NAME_ACS)
        }))
        self.addAction(UIAlertAction(title: "(z..a) alphabetical order", style: .default, handler: {
            (action) -> Void in
            DataManager.shared.setSortType(type: eSortType.NAME_DESC)
            DataManager.shared.sortAllNotes(sortType: eSortType.NAME_DESC)
            print("desc")
        }))
        self.addAction(UIAlertAction(title: "↑ creation date", style: .default, handler: {
            (action) -> Void in
            DataManager.shared.setSortType(type: eSortType.CRDATE_ASC)
            DataManager.shared.sortAllNotes(sortType: eSortType.CRDATE_ASC)
        }))
        self.addAction(UIAlertAction(title: "↓ creation date", style: .default, handler: {
            (action) -> Void in
            DataManager.shared.setSortType(type: eSortType.CRDATE_DESC)
            DataManager.shared.sortAllNotes(sortType: eSortType.CRDATE_DESC)
        }))
        self.addAction(UIAlertAction(title: "↑ modification date", style: .default, handler: {
            (action) -> Void in
            DataManager.shared.setSortType(type: eSortType.MODDATE_ASC)
            DataManager.shared.sortAllNotes(sortType: eSortType.MODDATE_ASC)
        }))
        self.addAction(UIAlertAction(title: "↓ modification date", style: .default, handler: {
            (action) -> Void in
            DataManager.shared.setSortType(type: eSortType.MODDATE_DESC)
            DataManager.shared.sortAllNotes(sortType: eSortType.MODDATE_DESC)
        }))
        self.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action) -> Void in
            print("cancel")
        }))
        self.view.tintColor = UIColor(red: 0.49, green: 0.17, blue: 0.2, alpha: 1)
    }

    override func viewDidDisappear(_ animated: Bool) {
        if(delegate != nil) {
            delegate?.updateSourceView()
        }
    }
}
