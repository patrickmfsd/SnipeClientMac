//
//  Components.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 19/6/2024.
//

import Foundation

import Foundation

struct ComponentsResponse: Codable {
    let total: Int
    let rows: [Component]
}

struct Component: Codable, Identifiable {
    let id: Int
    let name: String
    let image: String?
    let serial: String
    let location: ComponentsLocation
    let qty: Int
    let minAmt: Int
    let category: ComponentsCategory
    let supplier: ComponentsSupplier
    let orderNumber: String
    let purchaseDate: ComponentsPurchaseDate
    let purchaseCost: String
    let remaining: Int
    let company: ComponentsCompany
    let notes: String?
    let createdAt: ComponentsTimestamp
    let updatedAt: ComponentsTimestamp
    let userCanCheckout: Int
    let availableActions: ComponentsAvailableActions
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case serial
        case location
        case qty
        case minAmt = "min_amt"
        case category
        case supplier
        case orderNumber = "order_number"
        case purchaseDate = "purchase_date"
        case purchaseCost = "purchase_cost"
        case remaining
        case company
        case notes
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userCanCheckout = "user_can_checkout"
        case availableActions = "available_actions"
    }
}

struct ComponentsLocation: Codable {
    let id: Int
    let name: String
}

struct ComponentsCategory: Codable {
    let id: Int
    let name: String
}

struct ComponentsSupplier: Codable {
    let id: Int
    let name: String
}

struct ComponentsPurchaseDate: Codable {
    let date: String
    let formatted: String
}

struct ComponentsCompany: Codable {
    let id: Int
    let name: String
}

struct ComponentsTimestamp: Codable {
    let datetime: String
    let formatted: String
}

struct ComponentsAvailableActions: Codable {
    let checkout: Bool
    let checkin: Bool
    let update: Bool
    let delete: Bool
}
