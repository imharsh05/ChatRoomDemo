//
//  LoginViewController.swift
//  ChatRoom
//
//  Created by Harsh Patel on 29/09/20.
//  Copyright © 2020 Harsh Patel. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
           
              if let er = error {
              print(er.localizedDescription)
              let alert = UIAlertController(title: "Login fail", message: "email id or password are invalid", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
              
              } else {
                
              self.performSegue(withIdentifier:K.loginSegue, sender: self)
              
              }
            }
        }
    }
    
}
