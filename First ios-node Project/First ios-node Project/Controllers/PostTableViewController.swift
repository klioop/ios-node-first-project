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
    
    // MARK: - Selector methods
    @objc func createNewPost() {
        print("createNewPost() called")
        performSegue(withIdentifier: K.Segue.postTableSegue, sender: self)
    }
    
    fileprivate func refreshHandler() {
        print("rerefreshHandler() called")
        
        DispatchQueue.main.async() {
            self.postBrain.posts?.removeAll()
            self.pageNumber = 0
            print("refreshHandler - \((self.postBrain.posts?.count)!)")
            
            let refreshParameter = ["page": self.pageNumber] as NSMutableDictionary
            
            self.httpRequest.postRequest(with: K.EndPoint.posts, requestBody: refreshParameter, completion: self.postBrain.loadPosts)
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if indexPath.row == (self.postBrain.posts?.count)! - 1 {
                print("pageNumber ---- \(self.pageNumber)")
                self.pageNumber += 1
                let param = ["page": self.pageNumber] as NSMutableDictionary
                self.httpRequest.postRequest(with: K.EndPoint.posts, requestBody: param, completion: self.postBrain.loadPosts)
            }
        }
        
        return cell
    }
}

extension PostTableViewController: UITableViewDelegate {
    
}


extension PostTableViewController: PostBrainDelegate {
    
    func tableViewReload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

