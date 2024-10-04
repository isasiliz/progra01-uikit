//
//  ApiNetwork.swift
//  navegationAppmirror
//
//  Created by Liz Isasi on 03/10/2024.
//

import Foundation

class ApiNetwork {
    
    func getStringUrl() -> String {
        return "https://auction-master-of-darkness-dev-00d8bbef4e9d.herokuapp.com"
    }
    
    enum Method: String {
        case post = "POST"
        case get = "GET"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    func doTaskWithCompletionHandler(requestBody: Data?, method: Method, path: String, completionHandler: @escaping (Result<Data, ApiError>) -> Void ) {
        // create a request
        
        let stringURL = getStringUrl()
        let url = URL(string: "\(stringURL)\(path)")
        
        // 1 forma de desempaquetar de forma segura un option
        guard let url = url else {
            completionHandler(.failure(.invalidUrl))
            return // returonamos si url == nil
        }
        // si sigue por aca, es que tenemos url, y ya no es mas optional
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let requestBody = requestBody {
            request.httpBody = requestBody
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let _ = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completionHandler(.failure(.connectionError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.dataIsNil))
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            print(json)
            
            if let httpResponse: HTTPURLResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                
                switch status {
                case 200..<300:
                    completionHandler(.success(data))
                    break
                case 401:
                    completionHandler(.failure(.authenticationError))
                    break
                case 403:
                    completionHandler(.failure(.refreshTokenExpired))
                    break
                case 400:
                    completionHandler(.failure(.requestError))
                    break
                case 500:
                    completionHandler(.failure(.serverError))
                    break
                default:
                    completionHandler(.failure(.unknownError))
                    return
                }
            }
        }
            .resume()
        
    }
}


enum ApiError: String, Error {
    case invalidUrl = "Invalid URL"
    case dataIsNil = "Data is nil"
    case connectionError = "Connection error"
    case authenticationError = "Authentication error"
    case refreshTokenExpired = "Refresh token expired"
    case requestError = "Request error"
    case serverError = "Server error"
    case unknownError = "Unknown error"
}
