//
//  ListOfRoomViewController.swift
//  First ios-node Project
//
//  Created by klioop on 2021/03/31.
//

import UIKit

class PostTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postBrain = PostBrain()
    var httpRequest = HttpRequest()
    
    var pageNumber : Int = 0
    var pageParameter = ["page": 0] as NSMutableDictionary
    
    var selectedPost: PostModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ListOfRoomViewController - viewDidLoad() called")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        postBrain.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewPost))
        
        httpRequest.postRequest(with: K.EndPoint.posts, requestBody: pageParameter, completion: postBrain.loadPosts)
        
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear() called")
        
        refreshHandler()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segue.postTableSegue2 {
            let vc = segue.destination as! PostDetailViewController
            vc.post = selectedPost
        }
    }
    
    // MARK: - Selector methods
    
    @objc func createNewPost() {
        print("createNewPost() called")
        performSegue(withIdentifier: K.Segue.postTableSegue, sender: self)
    }
    
    fileprivate func refreshHandler() {
        print("rerefreshHandler() called")
        
        DispatchQueue.main.async() { [weak self] in
            self?.postBrain.posts?.removeAll()
            self?.pageNumber = 0
            print("refreshHandler - \((self?.postBrain.posts?.count)!)")
            
            let refreshParameter = ["page": self?.pageNumber ?? 0] as NSMutableDictionary
            
            self?.httpRequest.postRequest(with: K.EndPoint.posts, requestBody: refreshParameter, completion: (self?.postBrain.loadPosts)!)
        }
    }
}


// MARK: - UITableViewDataSource methods

extension PostTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postBrain.posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Table.postTableCellId, for: indexPath) as! PostTableCell
        
        cell.textInput.text = postBrain.posts?[indexPath.row].title
        cell.bodyInput.text = postBrain.posts?[indexPath.row].body
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPost = postBrain.posts?[indexPath.row]
        
        performSegue(withIdentifier: K.Segue.postTableSegue2, sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            if indexPath.row == (self?.postBrain.posts?.count)! - 1 {
                print("pageNumber ---- \(self?.pageNumber ?? 0)")
                self?.pageNumber += 1
                let param = ["page": (self?.pageNumber ?? 0)] as NSMutableDictionary
                self?.httpRequest.postRequest(with: K.EndPoint.posts, requestBody: param, completion: (self?.postBrain.loadPosts)!)
            }
        }
    }
}

// MARK: - UITableViewDelegate methods

extension PostTableViewController: UITableViewDelegate {
}

// MARK: - PostBrainDelegate methods

extension PostTableViewController: PostBrainDelegate {
    
    func tableViewReload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

