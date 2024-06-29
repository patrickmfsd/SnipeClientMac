//
//  Components.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 19/6/2024.
//

import Foundation

struct ComponentsResponse: Codable {
    let total: Int
    let rows: [Component]
}

struct Component: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String?
    let serial: String?
    let location: String?
    let qty: Int
    let minAmt: Int
    let category: ComponentCategory
    let supplier: String?
    let orderNumber: String?
    let purchaseDate: String?
    let purchaseCost: String?
    let remaining: Int
    let company: String?
    let notes: String?
    let createdAt: ComponentDateInfo
    let updatedAt: ComponentDateInfo
    let userCanCheckout: Int
    let availableActions: ComponentAvailableActions
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, serial, location, qty
        case minAmt = "min_amt"
        case category, supplier
        case orderNumber = "order_number"
        case purchaseDate = "purchase_date"
        case purchaseCost = "purchase_cost"
        case remaining, company, notes
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userCanCheckout = "user_can_checkout"
        case availableActions = "available_actions"
    }
}

struct ComponentCategory: Codable {
    let id: Int
    let name: String
}

struct ComponentDateInfo: Codable {
    let datetime: String
    let formatted: String
}

struct ComponentAvailableActions: Codable {
    let checkout: Bool
    let checkin: Bool
    let update: Bool
    let delete: Bool
}
