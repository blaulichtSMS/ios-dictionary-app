//
//  DictionaryApi.swift
//  ios-dictionary-app
//
//  Created by Pauline Erika Bihler on 15.05.25.
//

import Foundation
import Moya

// Define the Dictionary API
enum DictionaryApi {
    case searchWord(word: String)
}

extension DictionaryApi: TargetType {
    
    var baseURL: URL {
           guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en") else { fatalError() }
           return url
       }
    
    var path: String {
        switch self{
        case .searchWord(let word):
            return "/\(word)"
        }
    }
    
    var method: Moya.Method {
            return .get
        }
    
    var task: Task {
            switch self {
            case .searchWord:
                return .requestPlain
            }
        }
    
    var headers: [String: String]? {
            return ["Content-type": "application/json"]
        }
    
    var sampleData: Data {
            return Data()
        }
}

let dictionaryProvider = MoyaProvider<DictionaryApi>()
//let dictionaryProvider = MoyaProvider<DictionaryApi>(plugins: [NetworkLoggerPlugin()])
