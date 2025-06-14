//
//  DictionaryView.swift
//  ios-dictionary-app
//
//  Created by Pauline Erika Bihler on 15.05.25.
//

import SwiftUI


struct DictionaryView: View {
    let wordDetails: [WordDetail]
    
    
    var body: some View {
        List(wordDetails, id: \.word) { detail in
            VStack(alignment: .leading) {
                Text(detail.word).font(.largeTitle).bold()
                Text(detail.phonetic ?? "No phonetics available").italic()
                
                
                
                ForEach(detail.meanings, id: \.partOfSpeech) { meaning in
                    Text(meaning.partOfSpeech.capitalized).bold()
                    ForEach(meaning.definitions, id: \.definition) { definition in
                        Text("• \(definition.definition)")
                    }
                }
                
                
            }
            .padding()
        }
    }
}

    


