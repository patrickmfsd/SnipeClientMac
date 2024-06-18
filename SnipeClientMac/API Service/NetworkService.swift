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
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
                print("Decoded data: \(decodedData)")
            } catch {
                completion(.failure(.decodingFailed(error)))
                print("Decoding failed: \(error.localizedDescription)")
            }
        }.resume()
    }
}
