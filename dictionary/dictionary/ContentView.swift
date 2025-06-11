//
//  ContentView.swift
//  dictionary
//
//  Created by Pauline Erika Bihler on 10.06.25.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var viewModel = DictionaryViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
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


/*
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}*/

/*
#Preview {
    ContentView()
}
*/
