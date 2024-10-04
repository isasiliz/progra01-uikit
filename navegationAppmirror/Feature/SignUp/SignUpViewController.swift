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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       usernameContentView.layer.cornerRadius = 10
        emailContentView.layer.cornerRadius = 10
        passwordContentView.layer.cornerRadius = 10
        signUpButton.layer.cornerRadius = 10
    }
    
    @IBAction func doSignUpDidPress(_ sender: Any) {
        doSignUp(username: usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    func doSignUp(username: String, email: String, password: String) {
        
        var request = URLRequest(url: getCreateUserUrl())
        
        request.httpMethod = "POST"
        
        let bodyDictionary: [String: Any] = [
            "username": username,
            "email": email,
            "password": password
        ]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: bodyDictionary)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.httpBody = bodyData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task =  URLSession.shared.dataTask(with: request) {data, response, error in
            if error != nil {
                print("error al crear el user", error)
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data!) as? [String: Any]
            print(json)
            
            DispatchQueue.main.async {
                self.presentLogingView()
            }
           
        }
            .resume()
    }

    func getCreateUserUrl() -> URL {
        let urlString = "https://auction-master-of-darkness-dev-00d8bbef4e9d.herokuapp.com/api/v1/user"
        let url = URL(string: urlString)!
        return url
    }

    func presentLogingView() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(identifier: "login_view_controller") as? LoginViewController
        loginViewController!.modalPresentationStyle = .fullScreen
        present(loginViewController!, animated: true, completion: nil)
    }
}






