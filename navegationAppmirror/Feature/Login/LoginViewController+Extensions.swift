//
//  LoginViewController+Extensions.swift
//  navegationAppmirror
//
//  Created by Liz Isasi on 18/10/2024.
//

import Foundation

// MARK: HeaderView Extensions
extension LoginViewController {
    func titleView() {
        loginTitleOutlet.text = NSLocalizedString("_LOGIN_TITLE", comment: "")
    }
    
    func subtitleView() {
        loginTitle2Outlet.text = NSLocalizedString("_LOGIN_TITLE_2", comment: "")
    }
}

// MARK: BodyView Extensions
extension LoginViewController {
    func setupUsernameView() {
        usernameContentView.layer.cornerRadius = 10
        usernameTitleOutlet.text = NSLocalizedString("_USERNAME_TITLE", comment: "")
    }
    
    func setupPasswordView() {
        passwordContentView.layer.cornerRadius = 10
        passwordTitleOutlet.text = NSLocalizedString("_PASSWORD_TITLE", comment: "")
        passwordTextField.text = "StrongPassword123!"
    }
    
    func setupLoginButtonView() {
        logInButtonOutlet.layer.cornerRadius = 10
        logInButtonOutlet.setTitle(NSLocalizedString("_LOGIN_BUTTON", comment: ""), for: .normal)
    }
    
    func setupForgotPasswordButtonView() {
        forgotPasswordButton.setTitle(NSLocalizedString("_FORGOT_PASSWORD_BUTTON", comment: ""), for: .normal)
    }
}

// MARK: FooterView Extensions
extension LoginViewController {
    func setupSignUpLinkView() {
        textAccountSignUpOutlet.text = NSLocalizedString("_SIGNUP_TEXT", comment: "")
        signUpButton.setTitle(NSLocalizedString("_SIGNUP_BUTTON", comment: ""), for: .normal)
    }
}
