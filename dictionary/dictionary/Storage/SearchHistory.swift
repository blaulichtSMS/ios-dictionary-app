//
//  SearchHistory.swift
//  dictionary
//
//  Created by Pauline Erika Bihler on 10.06.25.
//

import Foundation
import RealmSwift

class SearchHistory: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var word: String
    @Persisted var dateSearched: Date = Date()
}
