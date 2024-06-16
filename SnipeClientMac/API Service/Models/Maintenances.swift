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
    let rows: [Maintenances]
}

    // Row Model
struct Maintenances: Codable, Identifiable {
    let id: Int
    let asset: Asset
}

    // Asset Model
struct Asset: Codable {
    let id: Int
    let name: String
    let assetTag: String
    let title: String
    let location: Location
}

    // Location Model
struct Location: Codable {
    let id: Int
    let name: String
    let notes: String
    let supplier: Supplier
    let assetMaintenanceType: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case notes
        case supplier
        case assetMaintenanceType = "asset_maintenance_type"
    }
}

    // Supplier Model
struct Supplier: Codable {
    let cost: String
    let assetMaintenanceType: String
    let startDate: StartDate
}

    // StartDate Model
struct StartDate: Codable {
    let datetime: String
    let formatted: String
    let assetMaintenanceTime: Int
    let completionDate: CompletionDate
}

    // CompletionDate Model
struct CompletionDate: Codable {
    let datetime: String
    let formatted: String
    let userId: UserId
}

    // UserId Model
struct UserId: Codable {
    let id: Int
    let name: String
    let createdAt: CreatedAt
}

    // CreatedAt Model
struct CreatedAt: Codable {
    let datetime: String
    let formatted: String
    let updatedAt: UpdatedAt
}

    // UpdatedAt Model
struct UpdatedAt: Codable {
    let datetime: String
    let formatted: String
}

    // AvailableActions Model
struct MaintenancesAvailableActions: Codable {
    let update: Bool
    let delete: Bool
}
