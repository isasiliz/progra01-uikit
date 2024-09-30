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
        let username = UserDefaults.standard.string(forKey: "username") ?? "username"
        usernameLabel.text = "Hola \(username)"
        let email = UserDefaults.standard.string(forKey: "email")
        emailLabel.text = email
        
    }
    
}
