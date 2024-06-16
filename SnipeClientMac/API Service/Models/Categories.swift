//
//  Categories.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 1/6/2024.
//

import Foundation

// MARK: - CategoryResponse
struct CategoryResponse: Codable {
    let total: Int
    let rows: [Category]
}

// MARK: - Category
struct Category: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String?
    let categoryType: String
    let hasEULA: Bool
    let useDefaultEULA: Bool
    let eula: String
    let checkinEmail: Bool
    let requireAcceptance: Bool
    let itemCount: Int
    let assetsCount: Int
    let accessoriesCount: Int
    let consumablesCount: Int
    let componentsCount: Int
    let licensesCount: Int
    let createdAt: DateTimeInfo
    let updatedAt: DateTimeInfo
    let availableActions: AvailableActions
    
    enum CodingKeys: String, CodingKey {
        case id, name, image
        case categoryType = "category_type"
        case hasEULA = "has_eula"
        case useDefaultEULA = "use_default_eula"
        case eula
        case checkinEmail = "checkin_email"
        case requireAcceptance = "require_acceptance"
        case itemCount = "item_count"
        case assetsCount = "assets_count"
        case accessoriesCount = "accessories_count"
        case consumablesCount = "consumables_count"
        case componentsCount = "components_count"
        case licensesCount = "licenses_count"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case availableActions = "available_actions"
    }
}

struct DateTimeInfo: Codable {
    let datetime: String
    let formatted: String
}

struct AvailableActions: Codable {
    let update: Bool
    let delete: Bool
    let clone: Bool
    let restore: Bool
}
