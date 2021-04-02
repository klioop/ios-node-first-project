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
    var pageParameter = ["page": 0] as NSDictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ListOfRoomViewController - viewDidLoad() called")
        
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewPost))
        
        httpRequest.postRequest(with: K.EndPoint.posts, requestBody: pageParameter, completion: postBrain.loadPosts)
        
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - Selector methods
    @objc func createNewPost() {
        print("createNewPost() called")
        performSegue(withIdentifier: K.Segue.postTableSegue, sender: self)
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
    
}

