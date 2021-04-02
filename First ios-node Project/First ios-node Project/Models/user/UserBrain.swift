//
//  UserBrain.swift
//  First ios-node Project
//
//  Created by klioop on 2021/03/25.
//

import Foundation
import SwiftKeychainWrapper

protocol UserBrainDelegate: AnyObject {
    func userSignInCompleted (userSignedIn: UserModel)
}

struct UserBrain {
    
    weak var delegate: UserBrainDelegate?
    
    public func saveAuthToken (res: Result<UserData, Error>) -> Void {
        
        switch res {
        
        case .failure(let error):
            print(error.localizedDescription)
            
        case .success(let userData):
            let userInfo = userData.user
            
            // 로그인하고 받은 jwt 을 keyChain 에 저장... struct 파일에 저장하면 외부에서 접근이 가능해질까?
            let saveAuthToken: Bool = KeychainWrapper.standard.set(userData.token, forKey: "accessToken")
            let saveUserId: Bool = KeychainWrapper.standard.set(userInfo.id, forKey: "userId")
            
            if saveAuthToken, saveUserId {
                self.delegate?.userSignInCompleted(userSignedIn: UserModel(id: userInfo.id, email: userInfo.email))
            }
        }
    }
    
}

