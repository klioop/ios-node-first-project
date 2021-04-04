//
//  PostEditViewController.swift
//  First ios-node Project
//
//  Created by klioop on 2021/04/04.
//

import UIKit

protocol PostEditViewControllerDelegate: AnyObject {
    func editPostCompleted(postItem: PostModel)
}

class PostEditViewController: UIViewController {
    
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var bodyIntput: UITextView!
    
    var receviedPost: PostModel?
    var httpRequest = HttpRequest()
    
    weak var delegate: PostEditViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyIntput.layer.cornerRadius = bodyIntput.frame.size.width / 25
        
        titleInput.text = receviedPost?.title
        bodyIntput.text = receviedPost?.body
        
        print(receviedPost?.id ?? "")
        
        navigationItem.title = "Edit Post Here 😄"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Completed", style: .plain, target: self, action: #selector(editCompleted))
    }
    
    @objc fileprivate func editCompleted() {
        let titleToBeUpdated = titleInput.text!
        let bodyToBeUpdated = bodyIntput.text!
        
        let params = [ "title": titleToBeUpdated, "body": bodyToBeUpdated ] as NSMutableDictionary
        
        httpRequest.postRequestWithToken(with: "\(K.EndPoint.createPost)/\(receviedPost?.id ?? "")", requestBody: params, completion: editPostRequestCompletion)
        
    }
    
    fileprivate func editPostRequestCompletion (res: Result<PostDatum, Error>) -> Void {
        switch res {
        
        case .success(let postDatum):
            let temp = PostModel(id: postDatum.post.id, title: postDatum.post.title ?? "", body: postDatum.post.body ?? "")
            
            self.receviedPost? = temp
            self.delegate?.editPostCompleted(postItem: temp)
            
            DispatchQueue.main.async { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            
            print("Successfully editing the post!!")
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
