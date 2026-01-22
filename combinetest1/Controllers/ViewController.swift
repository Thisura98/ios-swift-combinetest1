//
//  ViewController.swift
//  combinetest1
//
//  Created by Thisura Dodangoda on 2026-01-06.
//

// Random Wisdom
// 1. The Memory Graph doesn't show UIKit objects unless they have a custom class.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var nameField: LoginField!
    @IBOutlet private weak var pwField: LoginField!
    @IBOutlet private weak var confirmPWField: LoginField!
    @IBOutlet private weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        nameField.setup(.name, "Enter your name", nil)
        pwField.setup(.password, "Enter a password", nil)
        confirmPWField.setup(.password, "Retype your password", nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
        // TODO
        print("Sign Up Button Pressed")
        view.endEditing(true)
    }
    
}

