//
//  NewsFeedApiManager.swift
//  NewsFeed
//
//  Created by Azharuddin 1 on 26/07/22.
//

import Foundation
let API_Key = "8155dc406adb4fe3a168144452f8e4c6"
class NewsFeedApiManager {
    let networkManager : NetworkManager
    init(networkManager: NetworkManager = NetworkManager()){
        self.networkManager = networkManager
    }
    func getNewsFeedData( completion: @escaping ( _ model: NewsModel?, _ error : String? ) -> Void){
        guard let newsUrl = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(API_Key)") else { return  }
        networkManager.fetchRequest(with: newsUrl, type: NewsModel.self) { result in
            switch result{
              case .success(let model):
                completion(model, nil)
              case .failure( _):
                completion(nil, nil)
            }
        }
    }
}


enum DemoError: Error {
    case BadURL
    case NoData
    case DecodingError
}

class NetworkManager {
    let responseHandler: ResponseHandlerDelegate
    let aPIHandler: APIHandlerDelegate
    init(aPIHandler: APIHandlerDelegate = APIHandler(), responseHandler: ResponseHandlerDelegate = ResponseHandler()){
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    func fetchRequest<T:Codable>(with url : URL, type:T.Type, completion:@escaping(Result<T, DemoError>) -> Void){
        aPIHandler.fetchData(url: url) { result in
            switch result{
            case .success(let data):
                self.responseHandler.fetchModel(type: type, data: data) { decodedResult in
                    switch decodedResult{
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


protocol APIHandlerDelegate {
    func fetchData(url: URL, completion: @escaping(Result<Data, DemoError>) -> Void)
}

class APIHandler: APIHandlerDelegate {
    
    func fetchData(url: URL, completion: @escaping(Result<Data, DemoError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.NoData))
            }
            completion(.success(data))
           
        }.resume()
    }
    
}

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, DemoError>) -> Void)
}

class ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: (Result<T, DemoError>) -> Void) {
        let commentResponse = try? JSONDecoder().decode(type, from: data)
        if let commentResponse = commentResponse {
            return completion(.success(commentResponse))
        } else {
            completion(.failure(.DecodingError))
        }
    }
    
}
