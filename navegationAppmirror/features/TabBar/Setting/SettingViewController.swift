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
        performSegue(withIdentifier: "logout_login_segue", sender: nil)
       
    }
    func borrarToken() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
    }
    
}

