//
//  PostData.swift
//  First ios-node Project
//
//  Created by klioop on 2021/04/01.
//

import Foundation

struct PostData: Decodable {
    
    let posts: [Post]
}

struct PostDatum: Decodable {
    
    let post: Post
}

struct Post: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, body, createdAt, updatedAt
    }
    
    let id : String
    let title : String?
    let body: String?
    let createdAt: String
    let updatedAt: String
}

