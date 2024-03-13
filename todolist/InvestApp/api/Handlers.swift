////
////  Handlers.swift
////  todolist
////
////  Created by Артем Аверьянов on 05.03.2024.
////

import Foundation

class Handlers {
    //ne2wto4n-te3chn4olo5gy
    static let API_NWTN = "https://alpha.temp.ru/api/2.95.0/"
    static let API_SNP = "https://interns-test-fe.snp.agency/api/v1/"
    static let scope = "crfcksoqlllalaooasodoasodasdasxmxmmakk1123123"
    
    static var session: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpShouldSetCookies = true
        sessionConfig.httpCookieStorage = HTTPCookieStorage.shared
        return URLSession(configuration: sessionConfig)
    }()
    
    static private func handleResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (Result<Data, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            completion(.failure(NSError(domain: "HTTPError", code: statusCode, userInfo: nil)))
            return
        }
        
        if let data = data {
            completion(.success(data))
        } else {
            completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
        }
    }
    
    static func deleteRequest(url: URL, scopeKey: String?, completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        if let scopeKey = scopeKey {
            request.addValue(scopeKey, forHTTPHeaderField: "scope-key")
        }
        
        
        let task = session.dataTask(with: request) { data, response, error in
            handleResponse(data: data, response: response, error: error) { result in
                completion(result)
            }
        }
        
        task.resume()
    }
    
    static func getRequest(url: URL, scopeKey: String?, completion: @escaping (Result<Data, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        if let scopeKey = scopeKey {
            request.addValue(scopeKey, forHTTPHeaderField: "scope-key")
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            handleResponse(data: data, response: response, error: error) { result in
                completion(result)
            }
        }
        
        task.resume()
    }
    
    static func postRequest(url: URL, scopeKey: String?, body: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        if let scopeKey = scopeKey {
            request.addValue(scopeKey, forHTTPHeaderField: "scope-key")
        }
        
        request.httpBody = body
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
                
        let task = session.dataTask(with: request) { data, response, error in
            handleResponse(data: data, response: response, error: error) { result in
                completion(result)
            }
        }
        
        task.resume()
    }
}
