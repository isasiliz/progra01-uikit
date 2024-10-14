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
    @IBOutlet weak var loginTitleOutlet: UILabel!
    @IBOutlet weak var loginTitle2Outlet: UILabel!
    @IBOutlet weak var usernameTitleOutlet: UILabel!
    @IBOutlet weak var passwordTitleOutlet: UILabel!
    @IBOutlet weak var textAccountSignUpOutlet: UILabel!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameContentView.layer.cornerRadius = 10
        passwordContentView.layer.cornerRadius = 10
        logInButtonOutlet.layer.cornerRadius = 10
        signUpButton.layer.cornerRadius = 10
        passwordTextField.text = "StrongPassword123!" //borrar esto desp
        loginTitleOutlet.text = NSLocalizedString("_LOGIN_TITLE", comment: "")
        loginTitle2Outlet.text = NSLocalizedString("_LOGIN_TITLE_2", comment: "")
        usernameTitleOutlet.text = NSLocalizedString("_USERNAME_TITLE", comment: "")
        passwordTitleOutlet.text = NSLocalizedString("_PASSWORD_TITLE", comment: "")
        textAccountSignUpOutlet.text = NSLocalizedString("_SIGNUP_TEXT", comment: "")
        logInButtonOutlet.setTitle(NSLocalizedString("_LOGIN_BUTTON", comment: ""), for: .normal)
        signUpButton.setTitle(NSLocalizedString("_SIGNUP_BUTTON", comment: ""), for: .normal)
        forgotPasswordButton.setTitle(NSLocalizedString("_FORGOT_PASSWORD_BUTTON", comment: ""), for: .normal)
        
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
                DispatchQueue.main.async {
                    switch error {
                    case .internetConnectionError:
                        self.showAlert("Connection Error", "Please check your internet connection.")
        
                    case .emptyData:
                        self.showAlert("Error", "No data received from the server.")
                        
                    case .invalidUrl:
                        self.showAlert("url", "Mesasage")
                        
                    case .requestError(title: let title, message: let message):
                        print(title, message)
                        self.showAlert(NSLocalizedString(title, comment: ""), NSLocalizedString(message, comment: ""))
                        
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
                    self.presentTabBarView()
                }
            }
        }
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
    
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}



