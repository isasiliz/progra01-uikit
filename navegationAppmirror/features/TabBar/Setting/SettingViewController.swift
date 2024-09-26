//
//  SettingViewController.swift
//  navegationAppmirror
//
//  Created by Liz Isasi on 24/08/2024.
//

import UIKit

class SettingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        borrarToken()
        presentLogingView()
        
    }
    
    func presentLogingView() {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(identifier: "login_view_controller") as? LoginViewController
        
        
        let nv = UINavigationController(rootViewController: loginViewController!)
        nv.modalPresentationStyle = .fullScreen
        present(nv, animated: true, completion: nil)
    }
    func borrarToken() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
    }
    
}

