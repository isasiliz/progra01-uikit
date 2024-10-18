//
//  SignInViewController.swift
//  navegationAppmirror
//
//  Created by Liz Isasi on 27/08/2024.
//

import UIKit
class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var usernameContentView: UIView!
    @IBOutlet weak var emailContentView: UIView!
    @IBOutlet weak var passwordContentView: UIView!
    @IBOutlet weak var usernameTitleOutlet: UILabel!
    @IBOutlet weak var emailTitleOutlet: UILabel!
    @IBOutlet weak var passwordTitleOutlet: UILabel!
    @IBOutlet weak var signUpTitleOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       usernameContentView.layer.cornerRadius = 10
        emailContentView.layer.cornerRadius = 10
        passwordContentView.layer.cornerRadius = 10
        signUpButton.layer.cornerRadius = 10
        signUpTitleOutlet.text = NSLocalizedString("_SIGNUP_TITLE", comment: "")
        usernameTitleOutlet.text = NSLocalizedString("_USERNAME_TITLE", comment: "")
        emailTitleOutlet.text = NSLocalizedString("_EMAIL_TITLE", comment: "")
        passwordTitleOutlet.text = NSLocalizedString("_PASSWORD_TITLE", comment: "")
        signUpButton.setTitle(NSLocalizedString("_SIGNUP_BUTTON", comment: ""), for: .normal)
    }
    
    @IBAction func doSignUpDidPress(_ sender: Any) {
        doSignUp(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    func doSignUp(username: String, email: String, password: String) {
        let apiNetwork = ApiNetwork()
        
        let bodyDictionary: [String: Any] = [
            "username": username,
            "email": email,
            "password": password
        ]
        
        apiNetwork.apiCall(path: "api/v1/user", method: "POST", json: bodyDictionary, completion: { dictionary, error in
            if let error = error {
                switch error {
                case .internetConnectionError:
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
                case .timeout:
                    break
                }
                return
            }
            
            DispatchQueue.main.async {
                self.presentLogingView()
            }
        })
    }

    func presentLogingView() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(identifier: "login_view_controller") as? LoginViewController
        loginViewController!.modalPresentationStyle = .fullScreen
        present(loginViewController!, animated: true, completion: nil)
    }
}






