//
//  ListOfRoomViewController.swift
//  First ios-node Project
//
//  Created by klioop on 2021/03/31.
//

import UIKit

class PostTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var httpRequest = HttpRequest()
    var posts = [PostModel]()
    
    var pageNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PostTableViewController - viewDidLoad() called")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewPost))
        
        httpRequest.postRequest(with: K.EndPoint.posts, requestBody: ["page": pageNumber] as NSMutableDictionary, completion: loadPosts)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear() called")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.refreshHandler()
        }
    }
    
    
    // MARK: - Selector methods
    
    @objc func createNewPost() {
        print("createNewPost() called")
        performSegue(withIdentifier: K.Segue.postTableSegue, sender: self)
    }
    
    fileprivate func refreshHandler() {
        print("rerefreshHandler() called")
        
        posts.removeAll()
        
        let refreshParameter = ["page": pageNumber] as NSMutableDictionary
        httpRequest.postRequest(with: K.EndPoint.posts, requestBody: refreshParameter, completion: (loadPosts))
        
        print("refreshHandler - \((posts.count))")
    }
    
    fileprivate func loadPosts (res: Result<PostData, Error>) -> Void {
        
        switch res {
        case .success(let postData):
            let postObjs = postData.posts
            
            for obj in postObjs {
                posts.append(PostModel(id: obj.id, title: obj.title ?? "" , body: obj.body ?? ""))
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}


// MARK: - UITableViewDataSource methods

extension PostTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Table.postTableCellId, for: indexPath) as! PostTableCell
        
        cell.textInput.text = posts[indexPath.row].title
        cell.bodyInput.text = posts[indexPath.row].body
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? PostDetailViewController {
            vc.post = posts[(tableView.indexPathForSelectedRow?.row)!]
        }
            
    }
}


// MARK: - UITableViewDelegate methods

extension PostTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: K.Segue.postTableSegue2, sender: nil)
    }
    
}

