//
//  ViewController.swift
//  combinetest1
//
//  Created by Thisura Dodangoda on 2026-01-06.
//

// Random Wisdom
// 1. The Memory Graph doesn't show UIKit objects unless they have a custom class.

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet private weak var nameField: LoginField!
    @IBOutlet private weak var pwField: LoginField!
    @IBOutlet private weak var confirmPWField: LoginField!
    @IBOutlet private weak var signUpButton: UIButton!
    
    private var viewModel = ViewModel()
    private var subscriber: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        nameField.setup(.name, "Enter your name", nil)
        pwField.setup(.password, "Enter a password", nil)
        confirmPWField.setup(.password, "Retype your password", nil)
        
        nameField?.onChange = { [weak self] (value) in
            self?.viewModel.name = value
        }
        
        pwField?.onChange = { [weak self] (value) in
            self?.viewModel.pw = value
        }
        
        confirmPWField?.onChange = { [weak self] (value) in
            self?.viewModel.pwConfirm = value
        }
        
        subscriber = viewModel.validToSubmit?
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: signUpButton)
    }
    
    private func justAcknowledge(){
        let _ = Just("Oh hey... the button was just pressed!")
            .sink { val in
                print(val)
            }
    }
    
    @IBAction func signUp(_ sender: Any) {
        // TODO
        justAcknowledge()
        view.endEditing(true)
    }
    
}

