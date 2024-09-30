//
//  ViewController.swift
//  navegationAppmirror
//
//  Created by Liz Isasi on 17/08/2024.
//

import UIKit

class SplashViewController: UIViewController {
    var isAuthenticated : Bool = false
    var username: String = ""
    var password: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkToken()
    }
    
    func checkToken() {
        let token = UserDefaults.standard.object(forKey: "accessToken") as? String
        print (token)
        if token != nil {
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isAuthenticated {
            presentTabBarView()
        } else {
            presentLogingView()
        }
        
    }
    
    func presentLogingView() {
        performSegue(withIdentifier: "splash_login_segue", sender: nil)
    }
    func presentTabBarView() {
        performSegue(withIdentifier: "splash_tabbar_segue", sender: nil)
    }
}




    


