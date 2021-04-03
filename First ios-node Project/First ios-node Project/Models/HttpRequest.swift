//
//  HttpRequest.swift
//  First ios-node Project
//
//  Created by klioop on 2021/03/30.
//

import Foundation
import SwiftKeychainWrapper

struct HttpRequest {
    
    
    public func postRequest<T: Decodable> (with url: String, requestBody: NSMutableDictionary, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let url = URL(string: "\(url)") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let body = try! JSONSerialization.data(withJSONObject: requestBody, options: .init())
        
        urlRequest.httpBody = body
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            let code = response.statusCode
            
            if (code >= 300) {
                
                let body = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                print("Response Status code: \(code)")
                print("Error Message: \(body["message"] ?? "Error!")")
                return
            }
            
            guard let data = data else { return }
            
//            let tempBody = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
//            print(tempBody)
            
            do {
                let responseBody = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseBody))
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
    
    public func postRequestWithToken<T: Decodable> (with url: String, requestBody: NSDictionary, completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let url = URL(string: "\(url)") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let body = try! JSONSerialization.data(withJSONObject: requestBody, options: .init())
        let RetrievedToken: String? = KeychainWrapper.standard.string(forKey: K.Key.userAccessToken)
        guard let token = RetrievedToken else { return }
        
        urlRequest.httpBody = body
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            let code = response.statusCode
            
            if (code >= 300) {
                
                let body = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                print("Response Status code: \(code)")
                print("Error Message: \(body["message"] ?? "Error!")")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let responseBody = try JSONDecoder().decode(T.self, from: data)
                completion(.success(responseBody))
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
    }
}
