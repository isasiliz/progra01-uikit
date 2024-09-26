//
//  ChancePasswordVie.swift
//  navegationAppmirror
//
//  Created by Liz Isasi on 16/09/2024.
//

import UIKit
class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
    }
    
    @IBAction func doChangePasswordDidPress(_ sender: Any) {
        
        if currentPasswordTextField.text?.isEmpty == true || newPasswordTextField.text?.isEmpty == true {
            errorLabel.text = "Can't leave fields empty"
            return
        }
        
        if newPasswordTextField.text != repeatPasswordTextField.text {
            errorLabel.text = "Passwords do not match"
            return
        }
        errorLabel.text = ""
        doChangePassword(currentPassword: currentPasswordTextField.text!, newPassword: newPasswordTextField.text!, repeatPassword: repeatPasswordTextField.text!)
        
    }
    
    func doChangePassword( currentPassword: String, newPassword: String, repeatPassword: String) {
        
        var request = URLRequest(url: changePasswordURL())
        
        request.httpMethod = "POST"
        
        let bodyDictionary = [
            "currentPassword": currentPassword,
            "newPassword": newPassword,
        ] as [String: Any]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: bodyDictionary)
        request.httpBody = bodyData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let token = UserDefaults.standard.object(forKey: "accessToken") as? String
        request.setValue(token!, forHTTPHeaderField: "Authorization")
        
        
        let _ = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //Primera etapa
            if error != nil {
                DispatchQueue.main.async {
                    self.errorLabel.text = "Algo se rompió, intente de nuevo"
                }
                return
            }
            //Para poder mostrar los mensajes personalizados de backend
            let json = try? JSONSerialization.jsonObject(with: data!) as? [String: Any]
            print(json)
            
            // Segunda etapa pasa por aca si hay un error en la url
         let httpResponse = response as? HTTPURLResponse
            if httpResponse?.statusCode == 404 {
                DispatchQueue.main.async {
                    if json?["message"] == nil {
                        self.errorLabel.text = "no se encontro la pagina" //aparentemente nunca va a venir un message desde backend
                    } else {
                        self.errorLabel.text = json?["message"] as? String
                    }
                }
                return
            }
            if httpResponse?.statusCode == 400 {
                DispatchQueue.main.async {
                    self.errorLabel.text = json?["message"] as? String
                }
                return
            }
            if httpResponse?.statusCode == 403 {
                DispatchQueue.main.async {
                    self.errorLabel.text = json?["message"] as? String
                    
                }
                
                return
            }
           
            
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
        }
            .resume()
        
        
    }
    
    func changePasswordURL() -> URL {
       let urlString = "https://auction-master-of-darkness-dev-00d8bbef4e9d.herokuapp.com/api/v1/change-password"
        let url = URL(string: urlString)!
        return url
    }
    
}
