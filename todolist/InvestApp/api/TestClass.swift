//
//  TestClass.swift
//  todolist
//
//  Created by Артем Аверьянов on 12.03.2024.
//

import Foundation

struct TestTitle: Codable {
    let title: String
}

class TestClass: ObservableObject {
    @Published var tests: TestsModel?
    
    static let shared: TestClass = TestClass()
    
    func getTestById(id: Int) -> TestModel? {
        if let list = tests?.tests {
            return list.first(where: { test in
                test.id == id
            })
        }
        return nil
    }

    func removeTest(id: Int, completion: ((TestModel?) -> Void)? = nil) {
        if let url = URL(string: "\(Handlers.API_SNP)tests/\(id)") {
            Handlers.deleteRequest(url: url, scopeKey: Handlers.scope) { result in
                switch result {
                case .success:
                    self.tests?.tests = self.tests!.tests.filter { $0.id != id }
                    completion?(nil)
                case .failure(let error):
                    print("Error: \(error)")
                    completion?(nil)
                }
            }
        } else {
            completion?(nil)
        }
    }
    
    func getTests(completion: @escaping (TestsModel?) -> Void) {
        if let url = URL(string: "\(Handlers.API_SNP)tests") {
            Handlers.getRequest(url: url, scopeKey: Handlers.scope) { result in
                switch result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(TestsModel.self, from: data)
                        DispatchQueue.main.async {
                            self.tests = decodedData
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
    
    func createTest(title: String, completion: @escaping (TestModel?) -> Void) {
        let body = TestTitle(title: title)
        do {
            let jsonData = try JSONEncoder().encode(body)
            print("Отправка запроса на создание теста...")
            if let url = URL(string: "\(Handlers.API_SNP)tests") {
                Handlers.postRequest(url: url, scopeKey: Handlers.scope, body: jsonData) { result in
                    switch result {
                    case .success(let data):
                        do {
                            let decodedData = try JSONDecoder().decode(TestModel.self, from: data)
                            DispatchQueue.main.async {
                                self.tests?.tests.insert(decodedData, at: 0)
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
        } catch {
            print("Error encoding TestTitle:", error)
        }
    }
}
