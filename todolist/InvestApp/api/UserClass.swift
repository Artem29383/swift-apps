//
//  User.swift
//  todolist
//
//  Created by Артем Аверьянов on 07.03.2024.
//

import Foundation

struct Credentials: Codable {
    let username: String
    let password: String
}

struct ConfirmCredentials {
    let username: String
    let password: String
    let confirmPassword: String
    let is_admin: Bool
}

class UserClass: ObservableObject {
    @Published var response: UserModel?
    @Published var loggedIn: Bool = false
    @Published var isLoading: Bool = true
    
    static let shared: UserClass = UserClass()
    
    init() {
        currentUser()
    }
    
    func request(_ urlString: String, _ jsonData: Data, completion: @escaping (UserModel?) -> Void) {
        if let url = URL(string: "\(Handlers.API_SNP)\(urlString)") {
            Handlers.postRequest(url: url, scopeKey: Handlers.scope, body: jsonData) { result in
                switch result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(UserModel.self, from: data)
                        DispatchQueue.main.async {
                            self.response = decodedData
                            completion(decodedData)
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                        completion(nil)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }
    
    func currentUser(completion: ((UserModel?) -> Void)? = nil) {
        isLoading = true
        CookieClass.loadCookies()
        if let url = URL(string: "\(Handlers.API_SNP)users/current") {
            print("url", url)
            Handlers.getRequest(url: url, scopeKey: Handlers.scope) { result in
                switch result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(UserModel.self, from: data)
                        DispatchQueue.main.async {
                            print("decodedData", decodedData)
                            self.response = decodedData
                            self.loggedIn = true
                            completion?(decodedData)
                            self.isLoading = false
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                        completion?(nil)
                        self.isLoading = false
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    completion?(nil)
                    self.isLoading = false
                }
            }
        } else {
            completion?(nil)
            self.isLoading = false
        }
    }
    
    func logout(completion: ((UserModel?) -> Void)? = nil) {
        if let url = URL(string: "\(Handlers.API_SNP)logout") {
            Handlers.deleteRequest(url: url, scopeKey: Handlers.scope) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        CookieClass.saveCookies()
                        self.response = nil
                        self.loggedIn = false
                        self.isLoading = false
                        completion?(nil)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    completion?(nil)
                }
            }
        } else {
            completion?(nil)
        }
    }
    
    func login(_ username: String, _ password: String, completion: ((UserModel?) -> Void)? = nil) {
        let credentials = Credentials(username: username, password: password)
        
        do {
            let jsonData = try JSONEncoder().encode(credentials)
            
            request("signin", jsonData) { data in
                CookieClass.saveCookies()
                if let _ = data {
                    self.loggedIn = true
                }
                
                completion?(data)
            }
        } catch {
            print("Error encoding credentials:", error)
        }
    }
}
