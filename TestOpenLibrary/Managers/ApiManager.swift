//
//  ApiManager.swift
//  TestOpenLibrary
//
//  Created by Александр Молчан on 13.04.23.
//

import Foundation
import Moya

enum ApiManager {
    case getBooksList
}

extension ApiManager: TargetType {
    var baseURL: URL {
        URL(string: "https://openlibrary.org/search.json")!
    }
    
    var path: String {
        ""
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain }
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var parameters: [String : Any]? {
        var parameters = [String: Any]()
        switch self {
            case .getBooksList:
                parameters["subject"] = "Potter"
            }
        return parameters
    }
    
    var encoding: ParameterEncoding {
        URLEncoding.queryString
    }
    
}
