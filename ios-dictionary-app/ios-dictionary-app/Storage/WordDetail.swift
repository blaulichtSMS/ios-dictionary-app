//
//  WordDetail.swift
//  ios-dictionary-app
//
//  Created by Pauline Erika Bihler on 15.05.25.
//

import Foundation

struct WordDetail: Codable {
    let word: String
    let phonetic: String?
    let origin: String?
    let meanings: [Meaning]
    let phonetics: [Phonetic]?
}

struct Phonetic: Codable {
    let text: String?
    let audio: String?
}

struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
}

struct Definition: Codable {
    let definition: String
    let example: String?
    let synonyms: [String]?
}
