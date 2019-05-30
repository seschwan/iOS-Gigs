//
//  LoginViewController.swift
//  iOSGigs
//
//  Created by Seschwan on 5/30/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    // MARK: - Outlets -
    @IBOutlet weak var signUpSegControl:  UISegmentedControl!
    // Text Fields
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    // Buttons
    @IBOutlet weak var signUpButton:      UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 3
        
    }
    
    // MARK: - Actions -
    @IBAction func signUpSegChanged(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func SignUpBtnPressed(_ sender: UIButton) {
    }
    
    

}
