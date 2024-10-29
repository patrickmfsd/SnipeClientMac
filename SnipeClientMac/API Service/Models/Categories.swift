//
//  Categories.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 1/6/2024.
//

import Foundation

// MARK: - CategoryResponse
struct CategoryResponse: Codable {
    let total: Int
    let rows: [Category]
}

struct Category: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String?
    let categoryType: String
    let hasEula: Bool
    let useDefaultEula: Bool
    let eula: String?
    let checkinEmail: Bool
    let requireAcceptance: Bool
    let itemCount: Int
    let assetsCount: Int
    let accessoriesCount: Int
    let consumablesCount: Int
    let componentsCount: Int
    let licensesCount: Int
    let createdAt: CategoryDateTime
    let updatedAt: CategoryDateTime
    let availableActions: CategoryAvailableActions
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, categoryType = "category_type", hasEula = "has_eula", useDefaultEula = "use_default_eula", eula, checkinEmail = "checkin_email", requireAcceptance = "require_acceptance", itemCount = "item_count", assetsCount = "assets_count", accessoriesCount = "accessories_count", consumablesCount = "consumables_count", componentsCount = "components_count", licensesCount = "licenses_count", createdAt = "created_at", updatedAt = "updated_at", availableActions = "available_actions"
    }
}

struct CategoryDateTime: Codable {
    let datetime: String
    let formatted: String
}

struct CategoryAvailableActions: Codable {
    let update: Bool
    let delete: Bool
}
