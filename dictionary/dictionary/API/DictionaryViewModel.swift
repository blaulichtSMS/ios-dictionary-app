//
//  DictionaryViewModel.swift
//  dictionary
//
//  Created by Pauline Erika Bihler on 10.06.25.
//

import Foundation
import Moya
import RealmSwift

class DictionaryViewModel: ObservableObject {
    @Published var searchHistory: [SearchHistory] = []
    @Published var wordDetails: [WordDetail] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let provider = dictionaryProvider
    private let realm = try! Realm()

    init() {
        loadHistory()
    }

    // Search for a word using the Dictionary API
    func searchWord(_ word: String) {
        if !searchHistory.contains(where: { $0.word == word }) {
            saveToHistory(word: word)
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

    // Save search history to Realm
    private func saveToHistory(word: String) {
        let history = SearchHistory()
        history.word = word

        try? realm.write {
            realm.add(history)
        }
        loadHistory()
    }

    // Load history from Realm
    private func loadHistory() {
        let results = realm.objects(SearchHistory.self).sorted(byKeyPath: "dateSearched", ascending: false)
        searchHistory = Array(results)
    }
 
}
