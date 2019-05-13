//
//  Data.swift
//  NotesApp
//
//  Created by Nadiia KUCHYNA on 09.05.19.
//  Copyright © 2019 Nadiia KUCHYNA. All rights reserved.
//

import Foundation

struct  Data
{
    var state: eState
    var sortType: eSortType
    var fetchOffset: Int
    var notes : [Note] = [Note]()
    var matchingItems = [Note]()
}
