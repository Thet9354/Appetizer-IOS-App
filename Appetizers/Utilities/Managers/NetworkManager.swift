//
//  NetworkManager.swift
//  Appetizers
//
//  Created by Phoon Thet Pine on 10/4/24.
//

import UIKit

// A singleton class responsible for managing network requests related to appetizers
final class NetworkManager {
    
    // Shared instance of the Network Manager
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
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
                completed(.failure(.invalidResponse))
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
    
    
    /// Asynchronously downloads an image from the specified URL string.
    /// - Parameters:
    ///   - urlString: The URL string from which to download the image.
    ///   - completed: A closure to be called upon completion of the image download. Returns an optional `UIImage`.
    func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void) {
        // Create a cache key using the URL string
        let cacheKey = NSString(string: urlString)
        
        // Check if the image is already cached, if so, return it immediately
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        // Attempt to create a URL from the given URL string
        guard let url = URL(string: urlString) else {
            // If unable to create a URL, call the completion handler with nil
            completed(nil)
            return
        }
        
        // Create a data task to download the image from the URL
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            // Check if there's any data received and if it can be converted to a UIImage
            guard let data = data, let image = UIImage(data: data) else {
                // If unable to create a UIImage from the data, call the completion handler with nil
                completed(nil)
                return
            }
            
            // Cache the downloaded image using the cache key
            self.cache.setObject(image, forKey: cacheKey)
            
            // Call the completion handler with the downloaded image
            completed(image)
        }
        
        // Start the data task
        task.resume()
    }

}
