//
//  Untitled.swift
//  navegationAppmirror
//
//  Created by Liz Isasi on 30/09/2024.
//

import UIKit

class ForgotPasswordViewController : UIViewController {
    
    @IBOutlet weak var emailResetTextField: UITextField!
    @IBOutlet weak var resetLinkButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendResetLinkTapped(_ sender: Any) {
        sendEmail()
        
        let alert = UIAlertController(title: "Email Sent", message: "Your password reset link has been sent to your email.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    func sendEmail() {
        print("Email send")
    }
}

