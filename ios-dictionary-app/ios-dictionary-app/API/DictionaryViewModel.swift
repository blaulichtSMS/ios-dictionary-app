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
    //@Published var wordDetails: WordDetail?
    @Published var wordDetails: [WordDetail] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    
    
    private let provider = dictionaryProvider
    let realm = try! Realm()
    
    
    init() {
        loadHistory()
      }
     
    
    // Search for a word using the Dictionary API
    func searchWord(_ word: String) {
        
        //check if the word is already in the searchHistory, if not then save it to history(Realm)
        if !searchHistory.contains(where: { $0.word == word}) {
            saveToHistory(searchedWord: word)
        }
        
        isLoading = true
        provider.request(.searchWord(word: word)) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode([WordDetail].self, from: response.data)
                        self?.wordDetails = decodedData
                        self?.errorMessage = nil
                    } catch {
                        self?.errorMessage = "Failed to decode response"
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
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
        loadHistory()
    }
    
    
    // Load history from Realm
   
    func loadHistory() {
        let results = realm.objects(SearchHistory.self)
        searchHistory = Array(results)
    }
 
}



