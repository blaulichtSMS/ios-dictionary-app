//
//  DictionaryView.swift
//  ios-dictionary-app
//
//  Created by Pauline Erika Bihler on 15.05.25.
//

import SwiftUI

struct DictionaryView: View {
    let wordDetails: WordDetail

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Word: \(wordDetails.word)")
                .font(.title)

            if let phonetic = wordDetails.phonetic {
                Text("Phonetic: \(phonetic)")
            }

            if let origin = wordDetails.origin {
                Text("Origin: \(origin)")
            }


        }
        .padding()
    }
}
