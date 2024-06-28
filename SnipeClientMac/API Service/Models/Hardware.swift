//
//  Hardware.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 29/5/2024.
//

import Foundation

// MARK: - HardwareResponse
struct HardwareResponse: Codable {
    let total: Int
    let rows: [HardwareItem]
}

// MARK: - HardwareItem
struct HardwareItem: Codable, Identifiable, Equatable {
    let id: Int
    let name: String?
    let assetTag: String
    let serial: String?
    let model: HardwareModel?
    let byod: Bool?
    let requestable: Bool?
    let modelNumber: String?
    let eol: String?
    let assetEolDate: HardwareDateInfo?
    let statusLabel: HardwareStatusLabel?
    let category: HardwareCategory?
    let manufacturer: HardwareManufacturer?
    let supplier: HardwareSupplier?
    let notes: String?
    let orderNumber: String?
    let company: HardwareCompany?
    let location: HardwareLocation?
    let rtdLocation: HardwareLocation?
    let image: String?
    let qr: String?
    let altBarcode: String?
    let assignedTo: HardwareAssignedTo?
    let warrantyMonths: String?
    let warrantyExpires: String?
    let createdAt: HardwareDateTimeInfo?
    let updatedAt: HardwareDateTimeInfo?
    let lastAuditDate: String?
    let nextAuditDate: String?
    let deletedAt: String?
    let purchaseDate: HardwareDateInfo?
    let age: String?
    let lastCheckout: String?
    let lastCheckin: String?
    let expectedCheckin: String?
    let purchaseCost: String?
    let checkinCounter: Int?
    let checkoutCounter: Int?
    let requestsCounter: Int?
    let userCanCheckout: Bool?
    let bookValue: String?
    let customFields: [String: String]?
    let availableActions: HardwareAvailableActions?
    
    enum CodingKeys: String, CodingKey {
        case id, name, serial, model, byod, requestable, eol, notes, company, location, image, qr, altBarcode, deletedAt, age, bookValue, availableActions, customFields, lastCheckout, lastCheckin, expectedCheckin
        case assetTag = "asset_tag"
        case assignedTo = "assigned_to"
        case modelNumber = "model_number"
        case assetEolDate = "asset_eol_date"
        case statusLabel = "status_label"
        case category
        case manufacturer
        case supplier
        case orderNumber = "order_number"
        case rtdLocation = "rtd_location"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case purchaseDate = "purchase_date"
        case warrantyMonths
        case warrantyExpires
        case lastAuditDate = "last_audit_date"
        case nextAuditDate = "next_audit_date"
        case purchaseCost = "purchase_cost"
        case checkinCounter = "checkin_counter"
        case checkoutCounter = "checkout_counter"
        case requestsCounter = "requests_counter"
        case userCanCheckout = "user_can_checkout"
    }
    
    // Conformance to Equatable
    static func ==(lhs: HardwareItem, rhs: HardwareItem) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.assetTag == rhs.assetTag &&
        lhs.serial == rhs.serial &&
        lhs.manufacturer?.name == rhs.manufacturer?.name &&
        lhs.modelNumber == rhs.modelNumber &&
        lhs.category?.name == rhs.category?.name &&
        lhs.location?.name == rhs.location?.name &&
        lhs.assignedTo?.name == rhs.assignedTo?.name &&
        lhs.expectedCheckin == rhs.expectedCheckin &&
        lhs.image == rhs.image
    }
}

// MARK: - HardwareModel
struct HardwareModel: Codable {
    let id: Int
    let name: String
}

// MARK: - HardwareDateInfo
struct HardwareDateInfo: Codable {
    let date: String
    let formatted: String
}

// MARK: - HardwareStatusLabel
struct HardwareStatusLabel: Codable {
    let id: Int
    let name: String
    let statusType: String?
    let statusMeta: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case statusType = "status_type"
        case statusMeta = "status_meta"
    }
}

// MARK: - HardwareCategory
struct HardwareCategory: Codable {
    let id: Int
    let name: String
}

// MARK: - HardwareManufacturer
struct HardwareManufacturer: Codable {
    let id: Int
    let name: String
}

// MARK: - HardwareSupplier
struct HardwareSupplier: Codable {
    let id: Int
    let name: String
}

// MARK: - HardwareCompany
struct HardwareCompany: Codable {
    let id: Int?
    let name: String?
}

// MARK: - HardwareLocation
struct HardwareLocation: Codable {
    let id: Int
    let name: String
}

// MARK: - HardwareAssignedTo
struct HardwareAssignedTo: Codable {
    let id: Int
    let name: String
    let type: String
}

// MARK: - HardwareDateTimeInfo
struct HardwareDateTimeInfo: Codable {
    let datetime: String
    let formatted: String
}

// MARK: - HardwareAvailableActions
struct HardwareAvailableActions: Codable {
    let checkout: Bool?
    let checkin: Bool?
    let clone: Bool?
    let restore: Bool?
    let update: Bool?
    let delete: Bool?
}
