//
//  UserModel.swift
//  First ios-node Project
//
//  Created by klioop on 2021/03/25.
//

import Foundation

struct UserData: Decodable {
    
    let user: User
}

struct User: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name, email
        case id = "_id"
    }
    
    let id : String
    let name: String
    let email: String
}


