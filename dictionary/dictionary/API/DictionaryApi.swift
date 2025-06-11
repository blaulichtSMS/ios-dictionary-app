//
//  DictionaryApi.swift
//  dictionary
//
//  Created by Pauline Erika Bihler on 10.06.25.
//

import Foundation
import Moya

enum DictionaryAPI {
    case searchWord(word: String)
}

extension DictionaryAPI: TargetType {
    var baseURL: URL {
           guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en") else { fatalError() }
           return url
       }
    
    var path: String {
        switch self {
        case .searchWord(let word):
            return "/\(word)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}


let dictionaryProvider = MoyaProvider<DictionaryAPI>()

