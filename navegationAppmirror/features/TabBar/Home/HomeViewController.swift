//
//  HomeViewController.swift
//  navegationAppmirror
//
//  Created by Liz Isasi on 24/08/2024.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let token = UserDefaults.standard.string(forKey: "accessToken")
        tokenLabel.text = token
        let username = UserDefaults.standard.string(forKey: "username")
        usernameLabel.text = username
        let email = UserDefaults.standard.string(forKey: "email")
        emailLabel.text = email
        
    }
    
}
