//
//  NetworkManager.swift
//  TestOpenLibrary
//
//  Created by Александр Молчан on 13.04.23.
//

import Foundation
import Moya

typealias ObjectBlock<T: Decodable> = ((T) -> Void)
typealias Failure = ((Error) -> Void)

final class ProviderManager {
    private let provider = MoyaProvider<ApiManager>(plugins: [NetworkLoggerPlugin()])
    
    func getBooksData(success: ObjectBlock<ResponseData>?, failure: Failure?) {
        provider.request(.getBooksList) { result in
            switch result {
                case .success(let response):
                    do {
                        let data = try JSONDecoder().decode(ResponseData.self, from: response.data)
                        success?(data)
                    } catch let error {
                        failure?(error)
                    }
                case .failure(let error):
                    failure?(error)
            }
        }
    }
    
}
