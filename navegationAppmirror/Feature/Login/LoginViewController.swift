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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewmodel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView()
        bodyView()
        footerView()
        setupWire()
        
    }
    
    // MARK: HEADER
    func headerView() {
        titleView()
        subtitleView()
    }
    
    // MARK: BODY
    func bodyView() {
        setupUsernameView()
        setupPasswordView()
        setupLoginButtonView()
        setupForgotPasswordButtonView()
    }
    
    // MARK: FOOTER VIEW
    func footerView() {
        setupSignUpLinkView()
    }
    
    // MARK: Navigations
    func navigateToTabBar() {
        performSegue(withIdentifier: "tabbar_segue", sender: nil)
    }
    
    func navigateToSignUp() {
        performSegue(withIdentifier: "create_account_segue", sender: nil)
    }
    
    // MARK: Methods
    func doLogin() {
        guard let username = userNameTextField.text,
              let password = passwordTextField.text
        else { return }
        
        viewmodel.doLogin(username: username, password: password)
    }
    
    // MARK: Alerts
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Events
    @IBAction func doLogInDidPress(_ sender: Any) {
        doLogin()
    }
    
    @IBAction func signUpDidTapped(_ sender: Any) {
        navigateToSignUp()
    }
    
    // MARK: Wire
    func setupWire() {
        viewmodel.showAlert = { title, message in
            self.showAlert(title, message)
        }
        
        viewmodel.navigateToTabBar = {
            self.navigateToTabBar()
        }
        
        viewmodel.isLoading = { isLoading in
            isLoading ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }
}

