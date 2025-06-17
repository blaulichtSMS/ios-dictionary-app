//
//  DictionaryView.swift
//  dictionary
//
//  Created by Pauline Erika Bihler on 10.06.25.
//

import SwiftUI
import AVFoundation


struct DictionaryView: View {
    let wordDetails: [WordDetail]

    var body: some View {
        List(wordDetails, id: \.word) { detail in
            VStack(alignment: .leading) {
                Text(detail.word).font(.largeTitle).bold()
                Text(detail.origin ?? "No origin available").italic()
                
                ForEach(detail.meanings, id: \.partOfSpeech) { meaning in
                    Text(meaning.partOfSpeech.capitalized).bold()
                    ForEach(meaning.definitions, id: \.definition) { definition in
                        Text("• \(definition.definition)")
                    }
                }
                
                
                Button("Play Audio") {
                   playAudio(urlString: audio)
                              }
                
                if let audio = detail.phonetics?.first(where: { $0.audio != nil })?.audio {
                    Button("Play Audio") {
                       playAudio(urlString: audio)
                                  }
                              }
                          }
                      }
                  }
                  
                  private func playAudio(urlString: String) {
                      guard let url = URL(string: urlString) else { return }
                      let player = AVPlayer(url: url)
                      player.play()
                  }
                }
            
    
   
     

