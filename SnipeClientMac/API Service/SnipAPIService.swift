//
//  SnipAPIService.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI
import Combine

class SnipeAPIService: ObservableObject {
    @Published var hardwareItems: [HardwareItem] = []
    @Published var hardwareDetailItem: HardwareItem?

    @Published var userItem: [User] = []
    @Published var categoryItem: [Category] = []
    @Published var maintenancesItem: [MaintenanceItem] = []
    @Published var components: [Component] = []
    @Published var consumablesItems: [ConsumableItem] = []


    @Published var hardwareTotal: Int = 0
    @Published var userTotal: Int = 0
    @Published var maintenancesTotal: Int = 0
    @Published var categoryTotal: Int = 0
    @Published var consumablesTotal: Int = 0

    @Published var errorMessage: IdentifiableError?

    @AppStorage("apiURL") var apiURL = DefaultSettings.apiURL
    @AppStorage("apiKey") var apiKey = DefaultSettings.apiKey
    
    private let networkService = NetworkService()
    
    // MARK: - Fetch Hardware Assets
    // limit: Int?
    func fetchHardware(offset: Int = 0, sort: String = "created_at", order: String = "desc") {
        let queryItems = [
            // URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order)
        ]
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        networkService.fetchData(urlString: "\(apiURL)hardware", queryItems: queryItems, headers: headers) { (result: Result<HardwareResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.hardwareItems = response.rows
                        self.hardwareTotal = response.total
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func fetchSpecificHardware(id: Int32 = 0, offset: Int = 0, sort: String = "created_at", order: String = "desc") {
        let queryItems = [
            // URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order)
        ]
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        networkService.fetchData(urlString: "\(apiURL)hardware/\(id)", queryItems: queryItems, headers: headers) { (result: Result<HardwareItem, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.hardwareDetailItem = response
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Fetch Users
    func fetchUsers(offset: Int = 0, sort: String = "created_at", order: String = "desc", deletedUsersOnly: Bool = false, includeDeleted: Bool = false) {
        let queryItems = [
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "deleted", value: "\(deletedUsersOnly.description)"),
            URLQueryItem(name: "all", value: "\(includeDeleted.description)")
        ]
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        networkService.fetchData(urlString: "\(apiURL)users", queryItems: queryItems, headers: headers) { (result: Result<UserResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.userItem = response.rows
                        self.userTotal = response.total
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Fetch all categories
//    func fetchCategories(offset: Int = 0, sort: String = "created_at", order: String = "desc", category: String) {
    func fetchCategories(offset: Int = 0, sort: String = "created_at", order: String = "desc") {
        let queryItems = [
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order)
        ]
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        networkService.fetchData(urlString: "\(apiURL)categories", queryItems: queryItems, headers: headers) { (result: Result<CategoryResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                            // Assuming self.categoryItem and self.categoryTotal are properties in your class
                        self.categoryItem = response.rows
                        self.categoryTotal = response.total
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                            // Handle error as needed (e.g., show alert, log, etc.)
                }
            }
        }
    }
    
    // MARK: - Fetch asset maintenances
    func fetchAssetMaintenances(offset: Int = 0, sort: String = "created_at", order: String = "desc", assetID: Int32?) {
        let queryItems = [
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order),
            URLQueryItem(name: "asset_id", value: String(assetID ?? 0))
        ]
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        networkService.fetchData(urlString: "\(apiURL)maintenances", queryItems: queryItems, headers: headers) { (result: Result<MaintenancesResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.maintenancesItem = response.rows
                        self.maintenancesTotal = response.total
                        
                        print(self.maintenancesTotal)
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Fetch asset maintenances
    func fetchAllMaintenances(offset: Int = 0, sort: String = "created_at", order: String = "desc") {
        let queryItems = [
            URLQueryItem(name: "offset", value: String(offset)),
            URLQueryItem(name: "sort", value: sort),
            URLQueryItem(name: "order", value: order)
        ]
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        networkService.fetchData(urlString: "\(apiURL)maintenances", queryItems: queryItems, headers: headers) { (result: Result<MaintenancesResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.maintenancesItem = response.rows
                        self.maintenancesTotal = response.total
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Fetch all Components
    func fetchAllComponents(offset: Int = 0, sort: String = "created_at", order: String = "desc") {
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
        
        networkService.fetchData(urlString: "\(apiURL)components", queryItems: queryItems, headers: headers) { (result: Result<ComponentsResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.components = response.rows
                        self.maintenancesTotal = response.total
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Fetch all Consumables
    func fetchAllConsumables(offset: Int = 0, sort: String = "created_at", order: String = "desc") {
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
        
        networkService.fetchData(urlString: "\(apiURL)consumables", queryItems: queryItems, headers: headers) { (result: Result<ConsumablesResponse, NetworkError>) in
            DispatchQueue.main.async {
                switch result {
                    case .success(let response):
                        self.consumablesItems = response.rows
                        self.consumablesTotal = response.total
                    case .failure(let error):
                        self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }
        }
    }
}
