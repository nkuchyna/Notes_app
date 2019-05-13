//
//  DataManager.swift
//  NotesApp
//
//  Created by Nadiia KUCHYNA on 09.05.19.
//  Copyright © 2019 Nadiia KUCHYNA. All rights reserved.
//

import CoreData
import Foundation

class DataManager {
    static let shared = DataManager()
    let dateFormatter: DateFormatter
    var data: Data
    var noteSortFunctionArr : Dictionary = [eSortType : (Note, Note) -> Bool]()
    public var managedObjectContext : NSManagedObjectContext
    
    private init() {
        
        //Initialization of coredata
        guard let mdURL = Bundle.init(for: Note.self).url(forResource: "NotesApp", withExtension: "momd")
            else {
                fatalError("Error loading model from bundle")
        }
        guard let manObjModel = NSManagedObjectModel(contentsOf: mdURL) else {
            fatalError("Error initializing mom from: \(mdURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: manObjModel)
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc

        guard let dcURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Unable to resolve document directory")
        }
        let storeURL = dcURL.appendingPathComponent("note.sqlite")
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)

        } catch {
            fatalError("Error migrating store: \(error)")
        }
    
        //Aditional initialization
        self.dateFormatter = DateFormatter()
        self.data = Data(state: eState.EDIT, sortType: eSortType.MODDATE_DESC, fetchOffset: 0, notes: [Note]())
        self.data.notes = getNotePack()
        //Inialization of note sort function array
        noteSortFunctionArr[eSortType.NAME_ACS] = sortNameAsc
        noteSortFunctionArr[eSortType.NAME_DESC] = sortNameDesc
        noteSortFunctionArr[eSortType.CRDATE_ASC] = sortCrDateAsc
        noteSortFunctionArr[eSortType.CRDATE_DESC] = sortCrDateDesc
        noteSortFunctionArr[eSortType.MODDATE_ASC] = sortModDateAsc
        noteSortFunctionArr[eSortType.MODDATE_DESC] = sortModDateDesc
    }

    public func getDate(date: Date) -> String {
        self.dateFormatter.dateFormat = "MMMM dd, yyyy"
        return self.dateFormatter.string(from: date)
    }
    
    public func getTime(date: Date) -> String {
        self.dateFormatter.dateFormat = "hh:mm"
        return self.dateFormatter.string(from: date)
    }

    public func addNote(info: String, crDate : Date) {
        let note =  NSEntityDescription.insertNewObject(forEntityName: "Note", into: self.managedObjectContext) as! Note
        note.info = info
        note.crDate = crDate
        note.modDate = crDate
        self.managedObjectContext.insert(note)
        data.notes.append(note)
        save()
    }
 
    public func getNote(index : Int) -> Note {
        return data.notes[index]
    }
    
    public func getNotesNbr() -> Int {
        return  data.notes.count
    }
    
    public  func setState(state: eState) {
        self.data.state = state
    }
    
    public  func getState() -> eState {
        return self.data.state
    }

    public  func setSortType(type: eSortType) {
        self.data.sortType = type
    }
    
    public  func getSortType() -> eSortType {
        return self.data.sortType
    }
    
    
    public func appendNextNotePack() {
        data.notes += getNotePack()
    }
    
    public  func deleteNote(note : Note) {
        if let index = data.notes.index(of: note) {
            managedObjectContext.delete(data.notes[index])
            data.notes.remove(at: index)
            save()
        }
    }
    
    public  func deleteNoteAtIndex(index : Int) {
        if(data.notes.count > index) {
            managedObjectContext.delete(data.notes[index])
            data.notes.remove(at: index)
            save()
        }
    }

    public func editNote(note: Note, info: String, modDate: Date) {
        note.info = info
        note.modDate = modDate
        save()
    }
    
    public func getAllNotes() ->[Note] {
        let rqst = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let result = try managedObjectContext.fetch(rqst) as! [Note]
            return result
        }
        catch {
            print("Error! notes were not downloaded!")
            return []
        }
    }
    
    public func getNotePack() -> [Note] {
        let rqst = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        rqst.fetchLimit = 20
        rqst.fetchOffset = self.data.fetchOffset
        self.data.fetchOffset += 20
        do {
            let result = try managedObjectContext.fetch(rqst) as! [Note]
            return result
        }
        catch {
            print("Error! notes were not downloaded!")
            return []
        }
    }
    
    public func save() {
        if managedObjectContext.hasChanges {
            do {
                print("note was saved")
                try self.managedObjectContext.save()
            }
            catch(let err) {
                print("note was not saved")
                print(err)
            }
        }
    }
    
    public func sortAllNotes(sortType: eSortType) {
       if(data.notes.count > 1){
            data.notes.sort(by: noteSortFunctionArr[sortType]!)
        }
    }
    
    public func sortNotesArr( notesArr: inout [Note], sortType: eSortType) {
        if(notesArr.count > 1){
            notesArr.sort(by: noteSortFunctionArr[sortType]!)
        }
    }
}
