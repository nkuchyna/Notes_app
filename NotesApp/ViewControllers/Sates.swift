//
//  Sates.swift
//  NotesApp
//
//  Created by Nadiia KUCHYNA on 09.05.19.
//  Copyright © 2019 Nadiia KUCHYNA. All rights reserved.
//

import UIKit

protocol State: class {
    func    update(context: AddEditNoteViewController)
    func    editFormat()
    func    confirm()
}

class BaseState: State {
    private(set) weak var context: AddEditNoteViewController?
    func update(context: AddEditNoteViewController) {
        self.context = context
    }
    func    editFormat() {}
    func    confirm() {}
}

class AddState: BaseState {
    override func editFormat() {
        context?.navigationItem.title = "Add note"
        context?.confirmButton.title = "Save"
    }
    override func confirm() {
        DataManager.shared.addNote(info: (context?.infoTextView.text)!, crDate: Date())
    }
}

class EditState: BaseState {
    override func editFormat() {
        context?.infoTextView.text = context?.note?.info
        context?.navigationItem.title = "Edit note"
        context?.confirmButton.title = "Confirm"
    }
    override func confirm() {
        DataManager.shared.editNote(note: (context?.note)!, info: (context?.infoTextView.text)!, modDate: Date())
    }
}
