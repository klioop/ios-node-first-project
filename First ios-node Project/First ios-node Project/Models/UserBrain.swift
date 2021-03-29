//
//  UserBrain.swift
//  First ios-node Project
//
//  Created by klioop on 2021/03/25.
//

import Foundation
import SwiftKeychainWrapper

struct UserBrain {
    let baseUrl = "http://localhost:3000"
    
    public func postRequest<T: Decodable> (with userInfo: NSDictionary, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let url = URL(string: "\(baseUrl)/users") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        do {
            let body = try JSONSerialization.data(withJSONObject: userInfo, options: .init())
            
            urlRequest.httpBody = body
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let data = data else { return }
                
                do {
                let responseBody = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseBody))
                } catch {
                    completion(.failure(error))
                }
                
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    public var registerUserClosure: (Result<UserData ,Error>) -> Void = { (res: Result<UserData, Error>) in
        switch res {
        case .failure(let error):
            print(error.localizedDescription)
        case .success(let userData):
            let userInfo = userData.user
            print(userInfo.name)
            print(userInfo.email)
            print(userInfo.id)
        }
    }
    
}
