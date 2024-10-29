//
//  Consumables.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 25/6/2024.
//

import Foundation

    // Root model
struct ConsumablesResponse: Codable {
    let total: Int
    let rows: [ConsumableItem]
}

    // Inventory item model
struct ConsumableItem: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let image: String?
    let category: ConsumableCategory?
    let company: ConsumableCompany?
    let itemNo: String?
    let location: String?
    let manufacturer: ConsumableManufacturer?
    let supplier: ConsumableSupplier?
    let minAmt: Int?
    let modelNumber: String?
    let remaining: Int?
    let orderNumber: String?
    let purchaseCost: String?
    let purchaseDate: ConsumablePurchaseDate?
    let qty: Int?
    let notes: String?
    let createdAt: ConsumableDateTimeInfo?
    let updatedAt: ConsumableDateTimeInfo?
    let userCanCheckout: Bool
    let availableActions: ConsumableAvailableActions?
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, category, company, location, manufacturer, supplier, notes, qty
        case itemNo = "item_no"
        case minAmt = "min_amt"
        case modelNumber = "model_number"
        case remaining = "remaining"
        case orderNumber = "order_number"
        case purchaseCost = "purchase_cost"
        case purchaseDate = "purchase_date"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userCanCheckout = "user_can_checkout"
        case availableActions = "available_actions"
    }
}

// Nested models
struct ConsumableCategory: Codable, Equatable {
    let id: Int
    let name: String
}

struct ConsumableCompany: Codable, Equatable {
    let id: Int
    let name: String
}

struct ConsumableManufacturer: Codable, Equatable {
    let id: Int
    let name: String
}

struct ConsumableSupplier: Codable, Equatable {
    let id: Int
    let name: String
}

struct ConsumablePurchaseDate: Codable, Equatable {
    let date: String
    let formatted: String
}

struct ConsumableDateTimeInfo: Codable, Equatable {
    let datetime: String
    let formatted: String
}

struct ConsumableAvailableActions: Codable, Equatable {
    let checkout: Bool
    let checkin: Bool
    let update: Bool
    let delete: Bool
}
