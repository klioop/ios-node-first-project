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
    var posts = [Post]()
    
    var isFetching : Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PostTableViewController - viewDidLoad() called")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.tintColor = .yellow
        tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewPost))
        
        httpRequest.postRequestWithPagination(with: K.EndPoint.posts, pagination: false) { [weak self] result in
            
            switch result {
            case .success(let fetchedPosts):
                self?.posts.append(contentsOf: fetchedPosts)
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear() called")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.refreshHandler()
        }
    }
    
    
    
    
    // MARK: - Selector methods
    
    @objc func createNewPost() {
        print("createNewPost() called")
        
        performSegue(withIdentifier: K.Segue.postTableSegue, sender: self)
    }
    
    @objc func refreshData() {
        print("refreshData() - called")
        refreshHandler(refresh: true)
    }
    
    // MARK: - fileprivate methods
    
    fileprivate func createFooterView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100 ))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.color = .yellow
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    fileprivate func refreshHandler(refresh: Bool = false) {
        print("rerefreshHandler() called")
        
        if refresh {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.refreshControl?.beginRefreshing()
            }
        }
        
        posts.removeAll()
        httpRequest.currentPage = 1
        
        httpRequest.postRequestWithPagination(with: K.EndPoint.posts, pagination: false) { [weak self] result in
            
            switch result {
            case .success(let fetchedPosts):
                self?.posts.append(contentsOf: fetchedPosts)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self?.tableView.reloadData()
                    self?.httpRequest.isPaginating = false
                    if refresh {
                        self?.tableView.refreshControl?.endRefreshing()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        print("refreshHandler - \((posts.count))")
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

// MARK: - UIScrollViewDelegate methods

extension PostTableViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if (position + scrollView.frame.size.height > tableView.contentSize.height && !isFetching ){
            
            isFetching = true
            guard !httpRequest.isPaginating else { return }
            
            tableView.tableFooterView = createFooterView()
            
            httpRequest.postRequestWithPagination(with: K.EndPoint.posts, pagination: true) { [weak self] result in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    
                    DispatchQueue.main.async {
                        self?.tableView.tableFooterView = nil
                    }
                    
                    switch result {
                    case .success(let fetchedData):
                        self?.posts.append(contentsOf: fetchedData)
                        
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                            self?.isFetching = false
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

