//
//  ApiNetwork.swift
//  navegationAppmirror
//
//  Created by Liz Isasi on 10/10/2024.
//

import Foundation

class ApiNetwork {
    func apiCall(path: String, method: String, json: [String: Any], completion: @escaping ([String: Any]?, ApiError?) -> Void ) {
        guard let url = getUrl(path: path) else {
            completion(nil, .invalidUrl)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let data = try? JSONSerialization.data(withJSONObject: json) {
            request.httpBody = data
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil, .connectionError)
                return
            }
            
            guard let data else {
                completion(nil, .emptyData)
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                
                switch status {
                case 200...299:
                    completion(json, nil)
                    break
                case 400:
                    let title = json?["title"] as? String
                    let message = json?["message"] as? String
                    completion(nil, .requestError(title: title ?? "-", message: message ?? "-"))
                    break
                case 404:
                    completion(nil, .urlNotFound)
                    break
                default:
                    completion(nil, .unknownError)
                    return
                }
            } else {
                completion(nil, .unknownError)
            }
            
        }
        .resume()
    }
    
    private func getUrl(path: String) -> URL? {
        let urlString = "https://auction-master-of-darkness-dev-00d8bbef4e9d.herokuapp.com/\(path)"
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        return url
    }
    
}
