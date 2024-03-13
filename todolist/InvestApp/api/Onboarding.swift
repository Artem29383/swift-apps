//
//  Onboarding.swift
//  todolist
//
//  Created by Артем Аверьянов on 05.03.2024.
//

import Foundation

class Onboarding: ObservableObject {
    @Published var responseData: [SlideModel]?
    @Published var isLoading: Bool = true

    func fetchData(completion: @escaping ([SlideModel]?) -> Void) {
        isLoading = true
        if let url = URL(string: "\(Handlers.API_NWTN)banners/onboarding-banners") {
            Handlers.getRequest(url: url, scopeKey: nil) { result in
                switch result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode([SlideModel].self, from: data)
                        DispatchQueue.main.async {
                            self.responseData = decodedData
                            completion(decodedData)
                            self.isLoading = false
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                        completion(nil)
                        self.isLoading = false
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    completion(nil)
                    self.isLoading = false
                }
            }
        } else {
            completion(nil)
            self.isLoading = false
        }
    }
}
