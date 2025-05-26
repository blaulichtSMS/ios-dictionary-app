//
//  SearchHistory.swift
//  ios-dictionary-app
//
//  Created by Pauline Erika Bihler on 15.05.25.
//

import Foundation
import RealmSwift

class SearchHistory: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var word: String
    @Persisted var dateSearched: Date = Date()
}

