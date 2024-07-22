//
//  NetworkService.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import Foundation

struct IdentifiableError: Identifiable {
    let id = UUID()
    let message: String
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case noData
    case decodingFailed(Error)
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "The URL is invalid."
            case .requestFailed(let error):
                return error.localizedDescription
            case .noData:
                return "No data received from the server."
            case .decodingFailed(let error):
                return error.localizedDescription
        }
    }
}


class NetworkService {
    func decodeHTMLCharacters(from text: String) -> String {
        let replacements: [String: String] = [
            "&#039;": "'",
            "&quot;": "\"",
            "&amp;": "&",
            "&lt;": "<",
            "&gt;": ">"
            // Add other replacements as needed
        ]
        
        var result = text
        for (entity, replacement) in replacements {
            result = result.replacingOccurrences(of: entity, with: replacement)
        }
        
        return result
    }
    
    func fetchData<T: Decodable>(urlString: String, queryItems: [URLQueryItem] = [], headers: [String: String] = [:], completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard var components = URLComponents(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        // Debug print statements
        print("Request URL: \(url.absoluteString)")
        print("Request Headers: \(headers)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                print("Request failed: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                print("No data received")
                return
            }
            
            // Print raw JSON data for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON response: \(jsonString)")
                
                    // Replace HTML entities
                let cleanedJsonString = self.decodeHTMLCharacters(
                    from: jsonString
                )
                
                guard let cleanedData = cleanedJsonString.data(using: .utf8) else {
                    completion(.failure(.decodingFailed(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to encode cleaned JSON string to Data"]))))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: cleanedData)
                    completion(.success(decodedData))
                    print("Decoded data: \(decodedData)")
                } catch {
                    completion(.failure(.decodingFailed(error)))
                    print("Decoding failed: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    
    
}


//class NetworkService {
//    private let cache = URLCache.shared
//    private var requestTimestamps: [URL: Date] = [:]
//    private let rateLimit: TimeInterval = 1 // e.g., 1 request per second
//    
//    func fetchData<T: Decodable>(urlString: String, queryItems: [URLQueryItem] = [], headers: [String: String] = [:], completion: @escaping (Result<T, NetworkError>) -> Void) {
//        guard var components = URLComponents(string: urlString) else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        
//        components.queryItems = queryItems
//        
//        guard let url = components.url else {
//            completion(.failure(.invalidURL))
//            return
//        }
//        
//        if let lastRequestTime = requestTimestamps[url], Date().timeIntervalSince(lastRequestTime) < rateLimit {
//            completion(.failure(.requestFailed(NSError(domain: "", code: 429, userInfo: [NSLocalizedDescriptionKey: "Rate limit exceeded"]))))
//            return
//        }
//        
//        requestTimestamps[url] = Date()
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.timeoutInterval = 10
//        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
//        
//            // Check cache first
//        if let cachedResponse = cache.cachedResponse(for: request),
//           let data = cachedResponse.data as? T {
//            completion(.success(data))
//            return
//        }
//        
//        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
//            if let error = error {
//                completion(.failure(.requestFailed(error)))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//            
//                // Cache the response
//            if let response = response {
//                let cachedResponse = CachedURLResponse(response: response, data: data)
//                self?.cache.storeCachedResponse(cachedResponse, for: request)
//            }
//            
//            do {
//                let decodedData = try JSONDecoder().decode(T.self, from: data)
//                completion(.success(decodedData))
//            } catch {
//                completion(.failure(.decodingFailed(error)))
//            }
//        }.resume()
//    }
//}
