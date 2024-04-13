//
//  NetworkManager.swift
//  Appetizers
//
//  Created by Phoon Thet Pine on 10/4/24.
//

import UIKit
import Foundation

// A singleton class responsible for managing network requests related to appetizers
final class NetworkManager {
    
    // Shared instance of the Network Manager
    static let shared = NetworkManager()
    
    // Base URL for the network requests
    static let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
    
    // URL for fetching appetizers
    private let appetizerURL = baseURL + "appetizers"
    
    // Private initializer to prevent instantiation from outside the class
    private init() {}
    
    // Fetches the list of appetizers from the server
    // Paramter completed: A closure to be called upon completion of the network
    // Returns a 'Result' object containing either an array of 'Appetizer' objects
    func getAppetizers(completed: @escaping (Result<[Appetizer], APError>) -> Void) {
        guard let url = URL(string: appetizerURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidresponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(AppetizerResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
