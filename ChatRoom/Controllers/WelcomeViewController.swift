//
//  ViewController.swift
//  ChatRoom
//
//  Created by Harsh Patel on 28/09/20.
//  Copyright © 2020 Harsh Patel. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

