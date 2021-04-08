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
    
    var pageNumber : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PostTableViewController - viewDidLoad() called")
        
        tableView.dataSource = self
        tableView.delegate = self
        
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
    
    private func createFooterView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100 ))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        spinner.color = .yellow
        footerView.addSubview(spinner)
        spinner.startAnimating()
        
        return footerView
    }
    
    
    // MARK: - Selector methods
    
    @objc func createNewPost() {
        print("createNewPost() called")
        performSegue(withIdentifier: K.Segue.postTableSegue, sender: self)
    }
    
    fileprivate func refreshHandler() {
        print("rerefreshHandler() called")
        
        posts.removeAll()
        httpRequest.currentPage = 1
        
        httpRequest.postRequestWithPagination(with: K.EndPoint.posts, pagination: false) { [weak self] result in
            
            switch result {
            case .success(let fetchedPosts):
                self?.posts.append(contentsOf: fetchedPosts)
                print("rerefreshHandler() -- count : ", self?.posts.count ?? 0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self?.tableView.reloadData()
                    self?.httpRequest.isPaginating = false
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

extension PostTableViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        print(position)
        
        if position > tableView.contentSize.height - scrollView.frame.size.height + 50 {
            guard !httpRequest.isPaginating else { return }
            
            tableView.tableFooterView = createFooterView()
            
            httpRequest.postRequestWithPagination(with: K.EndPoint.posts, pagination: true) { [weak self] result in
                print("currentPage : ", self?.httpRequest.currentPage ?? 0)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    
                    DispatchQueue.main.async {
                        self?.tableView.tableFooterView = nil
                    }
                    
                    switch result {
                    case .success(let fetchedData):
                        self?.posts.append(contentsOf: fetchedData)
                        print("postRequestWithPagination() -- count : ", self?.posts.count ?? 0)
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

