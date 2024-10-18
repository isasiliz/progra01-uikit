//
//  LoginViewModel.swift
//  navegationAppmirror
//
//  Created by Liz Isasi on 18/10/2024.
//

import Foundation

class LoginViewModel {
    var showAlert: ((String, String) -> Void)?
    var navigateToTabBar: ( () -> Void )?
    var isLoading: ( (Bool) -> Void )?
    
    func doLogin(username: String, password: String) {
        isLoading?(true)
        
        let apiNetwork = ApiNetwork()
        let json: [String: Any] = [
            "email": username,
            "password": password
        ]
        
        apiNetwork.apiCall(path: "api/v1/login", method: "POST", json: json) { dictionary, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading?(false)
                    
                    switch error {
                    case .internetConnectionError:
                        self.showAlert?("Connection Error", "Please check your internet connection.")
        
                    case .emptyData:
                        self.showAlert?("Error", "No data received from the server.")
                        
                    case .invalidUrl:
                        self.showAlert?("url", "Mesasage")
                        
                    case .requestError(title: let title, message: let message):
                        print(title, message)
                        self.showAlert?(NSLocalizedString(title, comment: ""), NSLocalizedString(message, comment: ""))
                        
                        break
                    case .unknownError:
                        break
                    case .urlNotFound:
                        break
                    case .timeout:
                        break
                    }
                }
                return
            }
            
            if let dictionary = dictionary {
                self.saveAccessToken(dictionary)
                self.saveUsernameAndEmail(dictionary)
               
                DispatchQueue.main.async {
                    self.navigateToTabBar?()
                }
            }
        }
    }

    func saveAccessToken(_ json: [String: Any]?) {
        let accessToken = json?["accessToken"] as? String
        UserDefaults.standard.setValue(accessToken, forKey: "accessToken")
    }
    
    func saveUsernameAndEmail(_ json: [String: Any]?) {
        let user = json?["user"] as? [String: Any]
        
        let username = user?["username"] as? String
        UserDefaults.standard.setValue(username, forKey: "username")
        let email = user?["email"] as? String
        UserDefaults.standard.setValue(email, forKey: "email")
    }
}
