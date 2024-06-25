//
//  Consumables.swift
//  SnipeClientMac
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
struct ConsumableItem: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String?
    let category: Category
    let company: ConsumableCompany
    let itemNo: String
    let location: String?
    let manufacturer: ConsumableManufacturer
    let supplier: ConsumableSupplier
    let minAmt: Int
    let modelNumber: String?
    let remaining: Int
    let orderNumber: String
    let purchaseCost: String
    let purchaseDate: ConsumablePurchaseDate
    let qty: Int
    let notes: String?
    let createdAt: ConsumableDateTimeInfo
    let updatedAt: ConsumableDateTimeInfo
    let userCanCheckout: Bool
    let availableActions: ConsumableAvailableActions
    
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
struct ConsumableCategory: Codable {
    let id: Int
    let name: String
}

struct ConsumableCompany: Codable {
    let id: Int
    let name: String
}

struct ConsumableManufacturer: Codable {
    let id: Int
    let name: String
}

struct ConsumableSupplier: Codable {
    let id: Int
    let name: String
}

struct ConsumablePurchaseDate: Codable {
    let date: String
    let formatted: String
}

struct ConsumableDateTimeInfo: Codable {
    let datetime: String
    let formatted: String
}

struct ConsumableAvailableActions: Codable {
    let checkout: Bool
    let checkin: Bool
    let update: Bool
    let delete: Bool
}
