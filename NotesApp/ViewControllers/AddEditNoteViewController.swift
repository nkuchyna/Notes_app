//
//  AddNoteViewController.swift
//  NotesApp
//
//  Created by Nadiia KUCHYNA on 09.05.19.
//  Copyright © 2019 Nadiia KUCHYNA. All rights reserved.
//

import UIKit

class AddEditNoteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var infoTextView: DynamicTextView!
    @IBAction func shareButtonAction(_ sender: UIBarButtonItem) {
        if (self.validateString(string: infoTextView.text) != false) {
            let activityController = UIActivityViewController(activityItems: [infoTextView.text!], applicationActivities: nil)
            activityController.popoverPresentationController?.sourceView = self.view
            activityController.view.tintColor = UIColor(red: 0.49, green: 0.17, blue: 0.2, alpha: 1)
            present(activityController, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    @IBAction func confirmButtonAction(_ sender: UIBarButtonItem) {
        if (self.validateString(string: infoTextView.text) != false) {
            self.state.confirm()
            self.performSegue(withIdentifier: "backToNotesList", sender: self)
        }
    }

    private var state: State = AddState()
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        state.editFormat()
        infoTextView.delegate = self
        infoTextView.checkPlaceholder()
        self.view.addBackground(image: UIImage.init(named: "dotes")!)
    }

    func changeState(state : State)
    {
        self.state = state
        self.state.update(context : self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "backToNotesList") {
            DataManager.shared.setState(state: eState.SHOW)
        }
    }

    func back(sender: UIBarButtonItem) {
         DataManager.shared.setState(state: eState.SHOW)
        _ = navigationController?.popViewController(animated: false)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        infoTextView.disablePlaceholder()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        infoTextView.backgroundColor = UIColor.white
        infoTextView.checkPlaceholder()
    }

    func    validateString(string : String) -> Bool {
        if string.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showAlertMessage(vc: self, titleStr: "Error", messageStr: "Text is empty")
            return false
        }
        return true
    }
}
