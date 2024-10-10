//
//  LoginView.swift
//  navegationAppmirror
//
//  Created by Liz Isasi on 17/08/2024.
//

import Foundation
import UIKit


struct UserNameAndPasswordEntity: Encodable {
    let email: String
    let password: String
}

struct UserNameAndPasswordResponseEntity: Decodable {
    let accessToken: String
}

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
        // Closures
        
        let apiNetwork = ApiNetwork()
        
        
        let entity = UserNameAndPasswordEntity(email: username, password: password)
        let requestBody =  try? JSONEncoder().encode(entity)
        
        apiNetwork.doTaskWithCompletionHandler(requestBody: requestBody, method: .post, path: "/api/v1/login") { result in
            switch result {
            case .success(let data):
                
                let decoder = JSONDecoder()
                let response = try? decoder.decode(UserNameAndPasswordResponseEntity.self, from: data)
                
                
                if let response = response {
                    UserDefaults.standard.setValue(response.accessToken, forKey: "accessToken")
                    
                    DispatchQueue.main.async {
                        self.presentTabBarView()
                    }
                } else {
                    print("respose is nil, no se pudo serializar")
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    // llamar al alert
                }
                print(error.rawValue) // Invalid URL
                break
            }
        }
    }
    
    
    /*
     func doLogin_New_2(username: String, password: String) {
     // Async Await
     
     do {
     let response = await doTask(method: .post, path: "/api/v1/login")
     
     print(response.token)
     
     //mostramos en pantalla los datos be, en este caso recibimos el token, no mostramos nada en pantalla solo guardamos en el disco.
     } catch {
     // mostramos en pastalla un alert
     }
     }
     */
    
    /*func doLogin(username: String, password: String) {
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
     
     */
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



