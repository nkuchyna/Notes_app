//
//  NoteListViewController.swift
//  NotesApp
//
//  Created by Nadiia KUCHYNA on 09.05.19.
//  Copyright © 2019 Nadiia KUCHYNA. All rights reserved.
//

import UIKit

class NoteListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NoteSortAlertControllerDelegate, UISearchResultsUpdating {
    
    var matchingItems = [Note]()
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = resultSearchController?.searchBar.text {
            filterContent(for: searchText)
            self.notesTable.reloadData()
        }
    }
    
    func filterContent(for searchText: String){
        self.matchingItems = DataManager.shared.data.notes.filter { note in
            let isMatchingSearchText =    ((note.info?.lowercased().range(of: searchText.lowercased())) != nil) || searchText.lowercased().count == 0
            return isMatchingSearchText
        }
    }

    var resultSearchController:UISearchController? = nil

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(resultSearchController?.isActive)! {
            return matchingItems.count
        }
        return DataManager.shared.getNotesNbr()
    }
    
    @IBOutlet weak var notesTable: UITableView!
    
    var searchActive : Bool = false
    let sortAlert = NoteSortAlertController(title: "SORT", message: "Please, choose sort type of your notes", preferredStyle: .actionSheet)
    
    @IBAction func addNoteAction(_ sender: UIBarButtonItem) {
        DataManager.shared.setState(state: eState.ADD)
        performSegue(withIdentifier: "addEditNote", sender: self)
    }

    @IBAction func sortButtonAction(_ sender: UIBarButtonItem) {
        if(DataManager.shared.getAllNotes().count > 1) {
            present(sortAlert, animated: true, completion: nil)
        }
        else {
           showAlertMessage(vc: self, titleStr: "Error", messageStr: "There is nothing to sort")
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "note") as? NoteTableCell
        if(resultSearchController?.isActive)!{
            cell?.note = (matchingItems[indexPath.row].info, DataManager.shared.getDate(date: matchingItems[indexPath.row].modDate!), DataManager.shared.getTime(date: matchingItems[indexPath.row].modDate!) ) as? (String, String, String)
        }
        else {
            cell?.note = (DataManager.shared.getNote(index: indexPath.row).info, DataManager.shared.getDate(date: DataManager.shared.getNote(index: indexPath.row).modDate!), DataManager.shared.getTime(date: DataManager.shared.getNote(index: indexPath.row).modDate!)) as? (String, String, String)
        }
        return cell!
    }

    @IBAction func unWindSegue(segue : UIStoryboardSegue)
    {
        if(segue.identifier == "backToNotesList") {
            notesTable.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addEditNote") {
            if let editViewController = segue.destination as? AddEditNoteViewController {
                switch DataManager.shared.getState() {
                    case eState.ADD:
                        editViewController.changeState(state: AddState())
                    case eState.EDIT:
                        let indexPath = sender as! IndexPath
                        editViewController.note = DataManager.shared.getNote(index: indexPath.row)
                        editViewController.changeState(state: EditState())
                    default:
                        return;
                }
            }
        }
    }
    
    @IBOutlet weak var myView: UIView!
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") {(rowAction, indexPath) in
            DataManager.shared.setState(state: eState.EDIT)
            self.performSegue(withIdentifier: "addEditNote", sender: indexPath)
        }
        editAction.backgroundColor = UIColor(red: 0.37, green: 0.7, blue: 0.5, alpha: 1.0)
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete"){
            (rowAction, indexPath) in
            if(self.resultSearchController?.isActive)! {
                DataManager.shared.deleteNote(note: self.matchingItems[indexPath.row])
                self.matchingItems.remove(at: indexPath.row)
            }
            else
            {
                DataManager.shared.deleteNoteAtIndex(index: indexPath.row)
            }
            self.notesTable.reloadData()
        }
        deleteAction.backgroundColor = UIColor(red: 0.96, green: 0.26, blue: 0.21, alpha: 1.0)
        return [deleteAction, editAction]
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset: CGFloat = scrollView.contentOffset.y
        let maximumOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height
        // Change 50.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 50.0 {
            DataManager.shared.appendNextNotePack()
            self.notesTable.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        DataManager.shared.setState(state: eState.EDIT)
        performSegue(withIdentifier: "addEditNote", sender: indexPath)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sortAlert.delegate = self
        _gAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        _gAlert.view.tintColor = UIColor(red: 0.49, green: 0.17, blue: 0.2, alpha: 1)
        //search init
        resultSearchController = UISearchController(searchResultsController: nil)
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search note..."
        myView.addSubview((resultSearchController?.searchBar)!)
        resultSearchController?.searchResultsUpdater = self
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = false
        resultSearchController?.searchBar.tintColor = UIColor.black
        resultSearchController?.searchBar.barTintColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1)
        definesPresentationContext = true
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.49, green: 0.17, blue: 0.2, alpha: 1)
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DataManager.shared.sortAllNotes(sortType:  DataManager.shared.getSortType())
    }

    func updateSourceView() {
        notesTable.reloadData()
    }
}
