//
//  PostBrain.swift
//  First ios-node Project
//
//  Created by klioop on 2021/04/01.
//

import Foundation

class PostBrain {
    
    var posts: [PostModel]?
    
    public func loadPosts (res: Result<PostData, Error>) -> Void {
        
        switch res {
        
        case .success(let postData):
            
            let postObjs = postData.posts
            var postModels = [PostModel]()
            
            postObjs.forEach {
                postModels.append(PostModel(id: $0.id, title: $0.title ?? "", body: $0.body ?? ""))
            }
            
            self.posts = postModels
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
