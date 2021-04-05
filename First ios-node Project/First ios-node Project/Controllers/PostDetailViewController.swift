//
//  PostDetailViewController.swift
//  First ios-node Project
//
//  Created by klioop on 2021/04/04.
//

import UIKit
import SwiftKeychainWrapper

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var titleOfSelectedPost: UITextField!
    @IBOutlet weak var bodyOfSelectedPost: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var post: PostModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleOfSelectedPost.text = post?.title
        bodyOfSelectedPost.text = post?.body
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(goToEditPostVC))
        
        deleteButton.addTarget(self, action: #selector(deletePost), for: .touchUpInside)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.postDetailSegue {
            let vc = segue.destination as! PostEditViewController
            vc.receviedPost = post
            vc.delegate = self
        }
    }
    
    @objc fileprivate func goToEditPostVC() {
        print("PostDetailViewController - editPost() called")
        
        performSegue(withIdentifier: K.Segue.postDetailSegue, sender: self)
    }
    
    @objc fileprivate func deletePost() {
        guard let url = URL(string: "\(K.EndPoint.createPost)/\(self.post?.id ?? "")") else { return }
        
        let RetrievedToken: String? = KeychainWrapper.standard.string(forKey: K.Key.userAccessToken)
        guard let token = RetrievedToken else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let e = error {
                print(e.localizedDescription)
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode >= 300 {
                print("response status code: \(response.statusCode)")
                return
            }
            
            guard let data = data else { return }
            let responseBody = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
            
            DispatchQueue.main.async { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            
            print(responseBody["message"] ?? "")
        }.resume()
        
    }
}

// MARK: - PostEditViewControllerDelegate methods

extension PostDetailViewController: PostEditViewControllerDelegate {
    func editPostCompleted(postItem: PostModel) {
        DispatchQueue.main.async {
            self.titleOfSelectedPost.text = postItem.title
            self.bodyOfSelectedPost.text = postItem.body
        }
    }
}
