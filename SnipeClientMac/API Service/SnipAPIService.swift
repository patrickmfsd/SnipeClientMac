//
//  SnipAPIService.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI
import Combine

struct AnyCacheable {
    let value: Any
}

class SnipeAPIService: ObservableObject {
    @Published var hardwareItems: [HardwareItem] = []
    @Published var hardwareDetailItem: HardwareItem?
    
    @Published var userItem: [User] = []
    @Published var categoryItem: [Category] = []
    @Published var maintenancesItem: [Maintenance] = []
    @Published var components: [Component] = []
    @Published var consumablesItems: [ConsumableItem] = []
    
    @Published var hardwareTotal: Int = 0
    @Published var userTotal: Int = 0
    @Published var maintenancesTotal: Int = 0
    @Published var categoryTotal: Int = 0
    @Published var consumablesTotal: Int = 0
    @Published var componentsTotal: Int = 0
    
    @Published var errorMessage: IdentifiableError?
    
    @AppStorage("apiURL") var apiURL = DefaultSettings.apiURL
    @AppStorage("apiKey") var apiKey = DefaultSettings.apiKey
    
    @Published var isLoading: Bool = false
    
    private let networkService = NetworkService()
    private var cache: [String: AnyCacheable] = [:]
    private var lastRequestTime: [String: Date] = [:]
    private let requestInterval: TimeInterval = 30 // Seconds interval between requests
    
    private func isRequestAllowed(for key: String) -> Bool {
        guard let lastTime = lastRequestTime[key] else {
            return true
        }
        return Date().timeIntervalSince(lastTime) >= requestInterval
    }
    
    // MARK: - Fetch Hardware Assets
    func fetchHardware(limit: Int = 20, offset: Int = 0, searchTerm: String = "", sort: String = "created_at", order: String = "desc") {
        // Construct cache key
        let cacheKey = "hardwareItems\(limit)_\(offset)_\(searchTerm)_\(sort)_\(order)"
        
        // Clear cache if searchTerm is not empty
        if !searchTerm.isEmpty {
            // Iterate over existing cache keys and remove those that contain the search term
            for key in cache.keys {
                if key.contains(searchTerm) {
                    cache.removeValue(forKey: key)
                }
            }
        }
        
        // Prepare query items and headers
        let queryItems = [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "search", value: searchTerm),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order)
        ]
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        // Check for cached response
        if let cachedResponse = cache[cacheKey]?.value as? HardwareResponse {
            self.hardwareItems = cachedResponse.rows
            self.hardwareTotal = cachedResponse.total
            return
        }
        
        // Proceed with network request if not cached
        guard isRequestAllowed(for: cacheKey) else { return }
        self.isLoading = true
        
        networkService.fetchData(urlString: "\(apiURL)hardware", queryItems: queryItems, headers: headers) { (result: Result<HardwareResponse, NetworkError>) in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                    case .success(let response):
                        if offset == 0 {
                            self.hardwareItems = response.rows
                        } else {
                            self.hardwareItems.append(contentsOf: response.rows)
                        }
                        self.hardwareTotal = response.total
                        self.cache[cacheKey] = AnyCacheable(value: response)
                        self.lastRequestTime[cacheKey] = Date()
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func fetchSpecificHardware(id: Int32 = 0, offset: Int = 0, sort: String = "created_at", order: String = "desc") {
        let cacheKey = "hardwareDetailItem-\(id)"
        
        let queryItems = [
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order)
        ]
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        if let cachedResponse = cache[cacheKey]?.value as? HardwareItem {
            self.hardwareDetailItem = cachedResponse
            return
        }
        
        guard isRequestAllowed(for: cacheKey) else { return }
        self.isLoading = true
        
        networkService.fetchData(urlString: "\(apiURL)hardware/\(id)", queryItems: queryItems, headers: headers) { (result: Result<HardwareItem, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.hardwareDetailItem = response
                        self.cache[cacheKey] = AnyCacheable(value: response)
                        self.lastRequestTime[cacheKey] = Date()
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Fetch Users
    func fetchUsers(limit: Int = 20, offset: Int = 0, searchTerm: String = "", sort: String = "created_at", order: String = "desc", deletedUsersOnly: Bool = false, includeDeleted: Bool = false) {
        let cacheKey = "users_\(offset)_\(sort)_\(order)_\(searchTerm)_\(deletedUsersOnly)_\(includeDeleted)"
        
        
        // Clear cache if searchTerm is not empty
        if !searchTerm.isEmpty {
            // Iterate over existing cache keys and remove those that contain the search term
            for key in cache.keys {
                if key.contains(searchTerm) {
                    cache.removeValue(forKey: key)
                }
            }
        }
        
        let queryItems = [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "search", value: searchTerm),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "deleted", value: "\(deletedUsersOnly.description)"),
            URLQueryItem(name: "all", value: "\(includeDeleted.description)")
        ]
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        if let cachedResponse = cache[cacheKey]?.value as? UserResponse {
            self.userItem = cachedResponse.rows
            self.userTotal = cachedResponse.total
            return
        }
        
        guard isRequestAllowed(for: cacheKey) else { return }
        self.isLoading = true
        
        networkService.fetchData(urlString: "\(apiURL)users", queryItems: queryItems, headers: headers) { (result: Result<UserResponse, NetworkError>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                    case .success(let response):
                        if offset == 0 {
                            self.userItem = response.rows
                        } else {
                            self.userItem.append(contentsOf: response.rows)
                        }
                        self.userTotal = response.total
                        self.cache[cacheKey] = AnyCacheable(value: response)
                        self.lastRequestTime[cacheKey] = Date()
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
    
        // MARK: - Fetch all categories
    func fetchCategories(offset: Int = 0, sort: String = "created_at", order: String = "desc") {
        let cacheKey = "categories_\(offset)_\(sort)_\(order)"
        
        let queryItems = [
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order)
        ]
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        if let cachedResponse = cache[cacheKey]?.value as? CategoryResponse {
            self.categoryItem = cachedResponse.rows
            self.categoryTotal = cachedResponse.total
            return
        }
        
        guard isRequestAllowed(for: cacheKey) else { return }
        self.isLoading = true
        
        networkService.fetchData(urlString: "\(apiURL)categories", queryItems: queryItems, headers: headers) { (result: Result<CategoryResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        if offset == 0 {
                            self.categoryItem = response.rows
                        } else {
                            self.categoryItem.append(contentsOf: response.rows)
                        }
                        self.categoryTotal = response.total
                        self.cache[cacheKey] = AnyCacheable(value: response)
                        self.lastRequestTime[cacheKey] = Date()
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
    
        // MARK: - Fetch asset maintenances
    func fetchAssetMaintenances(offset: Int = 0, sort: String = "created_at", order: String = "desc", assetID: Int32? = nil) {
        let cacheKey = "asset_maintenances_\(offset)_\(sort)_\(order)_\(String(describing: assetID))"
        
        var queryItems = [
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order)
        ]
        
        if let assetID = assetID {
            queryItems.append(URLQueryItem(name: "asset_id", value: String(assetID)))
        }
        
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        if let cachedResponse = cache[cacheKey]?.value as? MaintenanceResponse {
            self.maintenancesItem = cachedResponse.rows
            self.maintenancesTotal = cachedResponse.total
            return
        }
        
        guard isRequestAllowed(for: cacheKey) else { return }
        self.isLoading = true
        
        networkService.fetchData(urlString: "\(apiURL)maintenances", queryItems: queryItems, headers: headers) { (result: Result<MaintenanceResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.maintenancesItem = response.rows
                        self.maintenancesTotal = response.total
                        self.cache[cacheKey] = AnyCacheable(value: response)
                        self.lastRequestTime[cacheKey] = Date()
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
    
        // MARK: - Fetch all Maintenances
    func fetchAllMaintenances(offset: Int = 0, sort: String = "created_at", order: String = "desc") {
        let cacheKey = "all_maintenances_\(offset)_\(sort)_\(order)"
        let queryItems = [
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order)
        ]
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        if let cachedResponse = cache[cacheKey]?.value as? MaintenanceResponse {
            self.maintenancesItem = cachedResponse.rows
            self.maintenancesTotal = cachedResponse.total
            return
        }
        
        guard isRequestAllowed(for: cacheKey) else { return }
        self.isLoading = true
        
        networkService.fetchData(urlString: "\(apiURL)maintenances", queryItems: queryItems, headers: headers) { (result: Result<MaintenanceResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.maintenancesItem = response.rows
                        self.maintenancesTotal = response.total
                        self.cache[cacheKey] = AnyCacheable(value: response)
                        self.lastRequestTime[cacheKey] = Date()
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
    
        // MARK: - Fetch all Components
    func fetchAllComponents(offset: Int = 0, sort: String = "created_at", order: String = "desc") {
        let cacheKey = "all_components_\(offset)_\(sort)_\(order)"
        let queryItems = [
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "order_number", value: "null"),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "expand", value: "true"),
        ]
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        if let cachedResponse = cache[cacheKey]?.value as? ComponentsResponse {
            self.components = cachedResponse.rows
            self.componentsTotal = cachedResponse.total
            return
        }
        
        guard isRequestAllowed(for: cacheKey) else { return }
        self.isLoading = true
        
        networkService.fetchData(urlString: "\(apiURL)components", queryItems: queryItems, headers: headers) { (result: Result<ComponentsResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.components = response.rows
                        self.componentsTotal = response.total
                        self.cache[cacheKey] = AnyCacheable(value: response)
                        self.lastRequestTime[cacheKey] = Date()
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
    
        // MARK: - Fetch all Consumables
    func fetchAllConsumables(offset: Int = 0, sort: String = "created_at", order: String = "desc") {
        let cacheKey = "all_consumables_\(offset)_\(sort)_\(order)"
        let queryItems = [
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "order_number", value: "null"),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "expand", value: "true"),
        ]
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        if let cachedResponse = cache[cacheKey]?.value as? ConsumablesResponse {
            self.consumablesItems = cachedResponse.rows
            self.consumablesTotal = cachedResponse.total
            return
        }
        
        guard isRequestAllowed(for: cacheKey) else { return }
        self.isLoading = true
        
        networkService.fetchData(urlString: "\(apiURL)consumables", queryItems: queryItems, headers: headers) { (result: Result<ConsumablesResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.consumablesItems = response.rows
                        self.consumablesTotal = response.total
                        self.cache[cacheKey] = AnyCacheable(value: response)
                        self.lastRequestTime[cacheKey] = Date()
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
}
