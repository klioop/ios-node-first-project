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
    
    var pageParameter = ["page": 0] as NSMutableDictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ListOfRoomViewController - viewDidLoad() called")
        
        tableView.dataSource = self
        tableView.delegate = self
        
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
    
    // MARK: - Selector methods
    @objc func createNewPost() {
        print("createNewPost() called")
        performSegue(withIdentifier: K.Segue.postTableSegue, sender: self)
    }
    
    fileprivate func refreshHandler() {
        postBrain.posts?.removeAll()
        print("refreshHandler - \((postBrain.posts?.count)!)")
        
        tableView.reloadData()
        
        let refreshParameter = ["page": 0] as NSMutableDictionary

//        httpRequest.postRequest(with: K.EndPoint.posts, requestBody: refreshParameter, completion: postBrain.loadPosts)
//
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
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
        
        if indexPath.row == (postBrain.posts?.count)! - 1 {
            pageParameter["page"] = pageParameter["page"] as! Int + 1
            print(pageParameter["page"]!)
        }
        
        
        return cell
    }
}

extension PostTableViewController: UITableViewDelegate {

}


