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
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(identifier: "login_view_controller") as? LoginViewController
        
        
        let nv = UINavigationController(rootViewController: loginViewController!)
        nv.modalPresentationStyle = .fullScreen
        present(nv, animated: true, completion: nil)
    }
    
    func presentTabBarView() {
        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        let tabBarViewController = storyboard.instantiateViewController(identifier: "TabBarViewController") as? TabBarViewController
        tabBarViewController!.modalPresentationStyle = .fullScreen
        present(tabBarViewController!, animated: true, completion: nil)
    }
}




    


