//
//  LoginViewController.swift
//  iOSGigs
//
//  Created by Seschwan on 5/30/19.
//  Copyright © 2019 Seschwan. All rights reserved.
//

import UIKit

enum LoginType {
    case signUp
    case signIn
}

class LoginVC: UIViewController {
    
    // MARK: - Outlets -
    @IBOutlet weak var signUpSegControl:  UISegmentedControl!
    // Text Fields
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    // Buttons
    @IBOutlet weak var signUpButton:      UIButton!
    
    
    var gigController: GigController!
    var loginType = LoginType.signUp
    

    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 3
        
    }
    
    
    
    // MARK: - Actions -
    @IBAction func signUpSegChanged(_ sender: UISegmentedControl) {
        if signUpSegControl.selectedSegmentIndex == 0 {
            loginType = .signUp
            signUpButton.setTitle("Sign Up", for: .normal)
        } else {
            loginType = .signIn
            signUpButton.setTitle("Sign In", for: .normal)
        }
    }
    
    @IBAction func SignUpBtnPressed(_ sender: UIButton) {
    }
}
