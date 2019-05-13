//
//  NoteTableCell.swift
//  NotesApp
//
//  Created by Nadiia KUCHYNA on 09.05.19.
//  Copyright © 2019 Nadiia KUCHYNA. All rights reserved.
//

import UIKit

class NoteTableCell: UITableViewCell {

    @IBOutlet weak var modificationDate: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var modificationTime: UILabel!
    
    var note : (String, String, String)? {
        didSet {
            if note != nil {
                info.text = note!.0.maxSize(size: 100)
                modificationDate.text = note!.1
                modificationTime.text = note!.2
                self.selectionStyle = .none
            }
        }
    }
}
