//
//  RegisterViewController.swift
//  First ios-node Project
//
//  Created by klioop on 2021/03/25.
//

import UIKit
import SwiftKeychainWrapper

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameContainer: UIView!
    @IBOutlet weak var passwordContainer: UIView!
    @IBOutlet weak var emailContainer: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let userBrain = UserBrain()
    let httpRequest = HttpRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameContainer.layer.cornerRadius = nameContainer.frame.size.width / 30
        nameContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        passwordContainer.layer.cornerRadius = passwordContainer.frame.size.width / 30
        passwordContainer.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        let requestBody = ["name": name, "email": email, "password":password] as NSMutableDictionary
        
        // http post request for registering
        httpRequest.postRequest(with: K.EndPoint.userUrl, requestBody: requestBody, completion: userBrain.saveAuthToken)
        
        performSegue(withIdentifier: K.Segue.registerSegue, sender: self)
    }
}


