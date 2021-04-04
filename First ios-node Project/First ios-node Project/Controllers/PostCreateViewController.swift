//
//  PostCreateViewController.swift
//  First ios-node Project
//
//  Created by klioop on 2021/04/02.
//

import UIKit

class PostCreateViewController: UIViewController {
    
    
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var bodyInput: UITextView!
    
    var httpRequest = HttpRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyInput.layer.cornerRadius = bodyInput.frame.size.width / 25
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addPost))
        
    }
    
    @objc fileprivate func addPost() {
        print("PostCreateViewController - addPost() called")
        
        let title = titleInput.text ?? "#NO TITLE"
        let body = bodyInput.text ?? ""
        
        
        let parameters = [ "title": title, "body": body ] as NSDictionary
        
        httpRequest.postRequestWithToken(with: K.EndPoint.createPost, requestBody: parameters, completion: createPostHandler)
        
    }
    
    fileprivate func createPostHandler(res: Result<PostDatum, Error>) -> Void {
        
        switch res {
        
        case .success(_):
            print("Successfully posting!")
            
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

