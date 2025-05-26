//
//  DictionaryViewModel.swift
//  ios-dictionary-app
//
//  Created by Pauline Erika Bihler on 15.05.25.
//

import Foundation
import Moya
import RealmSwift

class DictionaryViewModel {
    @Published var searchHistory: [SearchHistory] = []
    @Published var wordDetails: [WordDetail] = []
    
    private let provider = dictionaryProvider
    let realm = try! Realm()
    
    init() {
          
      }
    
    
    // Search for a word using the Dictionary API
    func searchWord(_ word: String) {
        //check if the word is already in the searchHistory, if not then save it to history(Realm)
        if !searchHistory.contains(where: {$0.word == word}) {
            saveToHistory(searchedWord: word)
        }
    }
    
    // Save search history(word) to Realm
    func saveToHistory(searchedWord: String) {
        let history = SearchHistory()
        history.word = searchedWord
        
        try! realm.write {
            realm.add(history)
        }
    }
    
    // Load history from Realm
    func loadHistory() {
        
    }

}
