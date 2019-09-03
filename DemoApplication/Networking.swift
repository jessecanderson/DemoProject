//
//  Networking.swift
//  DemoApplication
//
//  Created by Jesse Anderson on 9/2/19.
//  Copyright © 2019 Jesse Anderson. All rights reserved.
//

import Foundation


class Networking {
    
    let helper = Networking()
    
    static func makeAPICall(url: String, completion: @escaping (Result<APIResponse, Error>) -> Void) {
        if let url = URL(string: url) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data,
                    let response = response as? HTTPURLResponse else {
                        if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorCancelled {
                            completion(.failure(error))
                            return
                        }
                        return
                }
                
                guard (200 ... 299 ) ~= response.statusCode else {
                    print("\(response.statusCode)")
                    return
                }
                if let apiResponse = self.decodeFor(data: data) {
                    completion(.success(apiResponse))
                }
            }
            
            task.resume()
        }
    }
    
    static func decodeFor(data: Data) -> APIResponse? {
        let jsonDecoder = JSONDecoder()
        
        do {
            let apiResponse = try jsonDecoder.decode(APIResponse.self, from: data)
            return apiResponse
        } catch {
            print("\(error)")
        }
        
        return nil
    }
}
