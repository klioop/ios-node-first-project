//
//  RegisterViewController.swift
//  First ios-node Project
//
//  Created by klioop on 2021/03/25.
//

import UIKit
import SwiftKeychainWrapper


class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userBrain = UserBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        let requestBody = ["name": name, "email": email, "password":password] as NSDictionary
        
        // http post request for registering
        userBrain.postRequest(with: requestBody, completion: userBrain.registerUserClosure)
    }
}


