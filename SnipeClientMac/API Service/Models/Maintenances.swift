//
//  Maintenances.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 13/6/2024.
//

import Foundation

struct MaintenanceResponse: Codable {
    var total: Int
    var rows: [Maintenance]
}

struct Maintenance: Codable, Identifiable {
    var id: Int
    var asset: MaintenanceAsset?
    var model: MaintenanceModel?
    var statusLabel: MaintenanceStatusLabel?
    var company: String?
    var title: String?
    var location: MaintenanceLocation?
    var rtdLocation: MaintenanceLocation?
    var notes: String?
    var supplier: MaintenanceSupplier?
    var cost: Double?
    var assetMaintenanceType: String?
    var startDate: DateInfo?
    var assetMaintenanceTime: Int?
    var completionDate: DateInfo?
    var userId: MaintenanceUser?
    var createdAt: DateTimeInfo?
    var updatedAt: DateTimeInfo?
    var isWarranty: Int?
    var availableActions: [String: Bool]
    
    enum CodingKeys: String, CodingKey {
        case id, asset, model, statusLabel = "status_label", company, title, location, rtdLocation = "rtd_location", notes, supplier, cost, assetMaintenanceType = "asset_maintenance_type", startDate = "start_date", assetMaintenanceTime = "asset_maintenance_time", completionDate = "completion_date", userId = "user_id", createdAt = "created_at", updatedAt = "updated_at", isWarranty = "is_warranty", availableActions = "available_actions"
    }
}

struct MaintenanceAsset: Codable {
    var id: Int
    var name: String?
    var assetTag: String?
    var serial: String?
    var deletedAt: String?
    var createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, assetTag = "asset_tag", serial, deletedAt = "deleted_at", createdAt = "created_at"
    }
}

struct MaintenanceModel: Codable {
    var id: Int
    var name: String
}

struct MaintenanceStatusLabel: Codable {
    var id: Int
    var name: String
    var statusType: String
    var statusMeta: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, statusType = "status_type", statusMeta = "status_meta"
    }
}

struct MaintenanceLocation: Codable {
    var id: Int
    var name: String
}

struct MaintenanceSupplier: Codable {
    var id: Int
    var name: String
}

struct MaintenanceUser: Codable {
    var id: Int
    var name: String
}

struct DateInfo: Codable {
    var date: String
    var formatted: String
}

struct DateTimeInfo: Codable {
    var datetime: String
    var formatted: String
}
