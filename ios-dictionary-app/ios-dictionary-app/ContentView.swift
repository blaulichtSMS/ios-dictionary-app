//
//  ContentView.swift
//  ios-dictionary-app
//
//  Created by Pauline Erika Bihler on 14.05.25.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject private var viewModel = DictionaryViewModel()
    @State private var searchText = ""
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                
                TextField("Search a word", text: $searchText, onCommit: {
                    viewModel.searchWord(searchText)
                })
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                List(viewModel.searchHistory, id: \.id) { history in
                    Text(history.word)
                        .onTapGesture {
                            viewModel.searchWord(history.word)
                        }
                }
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)").foregroundColor(.red)
                } else {
                    DictionaryView(wordDetails: viewModel.wordDetails)
                }
            }
            .navigationTitle("Dictionary")
        }
    }
}



#Preview {
    ContentView()
}

/*
 Dictionary App:
    - Search Bar
        - Search words
 
    - Words:
        - Seach words
        - Words should show: Definition, Phonetic, Text, Audio, Origin
 
    - History:
        - Shows word searched
        - Words need to be clickable
 
Added Dependencies: Moya: for API; Realm: for storage

 */
