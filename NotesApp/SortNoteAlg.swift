//
//  SortNoteAlg.swift
//  NotesApp
//
//  Created by Nadiia KUCHYNA on 5/11/19.
//  Copyright © 2019 Nadiia KUCHYNA. All rights reserved.
//

import Foundation

func sortNameAsc(note1: Note, note2: Note) -> Bool {
    return note1.info! < note2.info!
}

func sortNameDesc(note1: Note, note2: Note) -> Bool {
    return note1.info! > note2.info!
}

func sortCrDateAsc(note1: Note, note2: Note) -> Bool {
    return note1.crDate! < note2.crDate!
}

func sortCrDateDesc(note1: Note, note2: Note) -> Bool {
    return note1.crDate! > note2.crDate!
}

func sortModDateAsc(note1: Note, note2: Note) -> Bool {
    return note1.modDate! < note2.modDate!
}

func sortModDateDesc(note1: Note, note2: Note) -> Bool {
    return note1.modDate! > note2.modDate!
}
