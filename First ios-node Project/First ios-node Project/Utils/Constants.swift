//
//  Constants.swift
//  First ios-node Project
//
//  Created by klioop on 2021/03/31.
//

import Foundation

struct K {
    static let localhostUrl = "http://localhost:3000"
    
    struct EndPoint {
        static let userUrl = "\(localhostUrl)/users"
        static let userSignIn = "\(userUrl)/signin"
        static let posts = "\(localhostUrl)/posts"
        static let createPost = "\(userUrl)/posts"
    }
    
    struct Segue {
        static let registerSegue = "goToRegisterSignIn"
        static let signInSegue = "goFromSignInToRooms"
        static let postTableSegue = "goToCreateView"
        static let postTableSegue2 = "goToDetailVC"
        static let postDetailSegue = "goToEditVC"
    }
    
    struct VC {
        static let signInVC = "signinVC"
    }
    
    struct Table {
        static let postTableCellId = "postCellid"
    }
    
    struct Key {
        static let userAccessToken = "accessToken"
    }
}
