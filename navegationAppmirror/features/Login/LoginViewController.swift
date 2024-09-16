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
    
    @IBAction func doSignUp(_ sender: Any) {
        presentSignUp()
    }
    
    func doLogin(username: String, password: String) {
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
    
   
    
    
    func presentTabBarView() {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        let tabBarViewController = storyboard.instantiateViewController(identifier: "TabBarViewController") as? TabBarViewController
        tabBarViewController!.modalPresentationStyle = .fullScreen
        present(tabBarViewController!, animated: true, completion: nil)
    }
    
    func presentSignUp() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let signUpViewController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        signUpViewController!.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(signUpViewController!, animated: true)
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



