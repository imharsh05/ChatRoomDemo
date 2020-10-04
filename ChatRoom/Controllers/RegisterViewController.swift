//
//  RegisterViewController.swift
//  ChatRoom
//
//  Created by Harsh Patel on 29/09/20.
//  Copyright © 2020 Harsh Patel. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
   //              print(e.localizedDescription)
                    let alert = UIAlertController(title: "Password is not safe", message: "\(e.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                    self.present(alert, animated: true)
                
                  } else {
    //             Navigate to chatViewController
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                  }
            }
            
          }
        
         }
    
}
