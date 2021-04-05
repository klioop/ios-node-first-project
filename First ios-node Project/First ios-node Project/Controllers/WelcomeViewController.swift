//
//  ViewController.swift
//  First ios-node Project
//
//  Created by klioop on 2021/03/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var tempButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    @IBAction func didButtonTapped() {
    }
    
    @IBAction func signInButtontapped() {
    }
}

