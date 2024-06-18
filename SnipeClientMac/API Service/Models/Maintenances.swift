//
//  Maintenances.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 13/6/2024.
//

import Foundation

    // ResponseBody Model
struct  MaintenancesResponse: Codable {
    let total: Int
    let rows: [MaintenanceItem]
}

struct MaintenanceItem: Codable, Identifiable {
    let id: Int
    let asset: Asset
    let title: String
    let location: MaintenanceLocation
    let notes: String?
    let supplier: MaintenanceSupplier?
    let cost: Double?
    let assetMaintenanceType: String
    let startDate: MaintenanceStartDate
    let assetMaintenanceTime: Int
    let completionDate: MaintenanceCompletionDate
    let userId: MaintenanceUser
    let createdAt: MaintenanceCreatedDate
    let updatedAt: MaintenanceUpdateDate
    let availableActions: MaintenanceAvailableActions
    
    enum CodingKeys: String, CodingKey {
        case id, asset, title, location, notes, supplier, cost
        case assetMaintenanceType = "asset_maintenance_type"
        case startDate = "start_date"
        case assetMaintenanceTime = "asset_maintenance_time"
        case completionDate = "completion_date"
        case userId = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case availableActions = "available_actions"
    }
}

struct Asset: Codable {
    let id: Int
    let name: String
    let assetTag: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case assetTag = "asset_tag"
    }
}

struct MaintenanceLocation: Codable {
    let id: Int
    let name: String
}

struct MaintenanceSupplier: Codable {
    let id: Int
    let name: String
}

struct MaintenanceUser: Codable {
    let id: Int
    let name: String
}

struct MaintenanceStartDate: Codable {
    let datetime: Int
    let formated: String
}

struct MaintenanceCompletionDate: Codable {
    let datetime: Int
    let formated: String
}

struct MaintenanceCreatedDate: Codable {
    let datetime: Int
    let formated: String
}

struct MaintenanceUpdateDate: Codable {
    let datetime: Int
    let formated: String
}

struct MaintenanceAvailableActions: Codable {
    let delete: Bool
    let update: Bool
        // Add other relevant properties
}
