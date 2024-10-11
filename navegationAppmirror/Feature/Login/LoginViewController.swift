//
//  LoginView.swift
//  navegationAppmirror
//
//  Created by Liz Isasi on 17/08/2024.
//

import Foundation
import UIKit
class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButtonOutlet: UIButton!
    @IBOutlet weak var usernameContentView: UIView!
    @IBOutlet weak var passwordContentView: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameContentView.layer.cornerRadius = 10
        passwordContentView.layer.cornerRadius = 10
        logInButtonOutlet.layer.cornerRadius = 10
        signUpButton.layer.cornerRadius = 10
        passwordTextField.text = "StrongPassword123!" //borrar esto desp
    }
    
    @IBAction func doLogInDidPress(_ sender: Any) {
        doLogin(username: userNameTextField.text!, password: passwordTextField.text!)
        
    }
    
    func doLogin(username: String, password: String) {
        let apiNetwork = ApiNetwork()
        let json: [String: Any] = [
            "email": username,
            "password": password
        ]
        
        apiNetwork.apiCall(path: "api/v1/login", method: "POST", json: json) { dictionary, error in
            if let error = error {
                switch error {
                case .connectionError:
                    
                    break
                case .emptyData:
                    break
                case .invalidUrl:
                    break
                case .requestError(title: let title, message: let message):
                    print(title, message)
                    break
                case .unknownError:
                    break
                case .urlNotFound:
                    break
                }
                return
            }
            
            if let dictionary = dictionary {
                self.saveAccessToken(dictionary)
                self.saveUsernameAndEmail(dictionary)
               
                DispatchQueue.main.async {
                    self.presentTabBarView()
                }
            }
        }
    }
    
    func doLogin2(username: String, password: String) {
        // create a request
        var request = URLRequest(url: getUrl() )
        
        request.httpMethod = "POST"
        
        let json: [String: Any] = [
            "email": username,
            "password": password
        ]
        
        let data = try? JSONSerialization.data(withJSONObject: json)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.httpBody = data
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                print("algo se rompio", error)
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data!) as? [String: Any]
            print(json)
            
            if json?["accessToken"] as? String == nil {
                print("no se, no vino el access token, todo mal")
                return
            }
            
            self.saveAccessToken(json)
            self.saveUsernameAndEmail(json)
           
            DispatchQueue.main.async {
                self.presentTabBarView()
            }
        }
            .resume()
        
    }
    
   
    @IBAction func signUpDidTapped(_ sender: Any) {
        performSegue(withIdentifier: "create_account_segue", sender: nil)
    }
    
    func presentTabBarView() {
        performSegue(withIdentifier: "tabbar_segue", sender: nil)
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
    
    func getUrl() -> URL {
        let urlString = "https://auction-master-of-darkness-dev-00d8bbef4e9d.herokuapp.com/api/v1/login"
        let url = URL(string: urlString)!
        
        return url
    }
    
    
  
}



