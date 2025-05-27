//
//  DictionaryViewModel.swift
//  ios-dictionary-app
//
//  Created by Pauline Erika Bihler on 15.05.25.
//

import Foundation
import Moya
import RealmSwift

class DictionaryViewModel: ObservableObject {
    
    @Published var searchHistory: [SearchHistory] = []
    @Published var wordDetails: WordDetail?
    
    
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
     
        
        provider.request(.searchWord(word: word)) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let statusCode = moyaResponse.statusCode
                let decoded = try? JSONDecoder().decode(WordDetail.self, from: data)
                
                DispatchQueue.main.async {
                    self.wordDetails = decoded
                }
                
            case let .failure(error):
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).  If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
                print("Error decoding JSON: \(error)")
                
            
            }
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
        let results = realm.objects(SearchHistory.self)
        searchHistory = Array(results)
    }

}
