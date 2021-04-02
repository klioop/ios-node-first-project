//
//  SignInViewController.swift
//  First ios-node Project
//
//  Created by klioop on 2021/03/25.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var user: UserModel?
    
    var userBrain = UserBrain()
    var httpRequest = HttpRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        let requestBody = ["email": email, "password": password] as NSDictionary
        
        userBrain.delegate = self
        
        // sign in request
        httpRequest.postRequest(with: K.EndPoint.userSignIn, requestBody: requestBody, completion: userBrain.saveAuthToken)
    }
}

extension SignInViewController: UserBrainDelegate {
    
    func userSignInCompleted(userSignedIn: UserModel) {
        print("SignInViewController - UserBrainDelegate")
        user = userSignedIn
        
        if let userEmail = user?.email {
            print("Signed In successfully for \(userEmail)")
            
            DispatchQueue.main.async{
                self.performSegue(withIdentifier: K.Segue.signInSegue, sender: self)
            }
        }
    }
}
