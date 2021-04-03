//
//  PostBrain.swift
//  First ios-node Project
//
//  Created by klioop on 2021/04/01.
//

import UIKit

protocol PostBrainDelegate: AnyObject {
    func tableViewReload()
}

class PostBrain {
    
    var delegate: PostBrainDelegate?
    var posts: [PostModel]? = []
    
    public func loadPosts (res: Result<PostData, Error>) -> Void {
        
        switch res {
        
        case .success(let postData):
            
            let postObjs = postData.posts
            
            postObjs.forEach {
                self.posts?.append(PostModel(id: $0.id, title: $0.title ?? "", body: $0.body ?? ""))
                self.delegate?.tableViewReload()
            }
            
            print((posts?.count)!)
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
