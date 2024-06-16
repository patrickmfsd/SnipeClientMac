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
struct HardwareItem: Codable, Identifiable {
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
    let warrantyMonths: Int?
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
        case id, name, serial, model, byod, requestable, eol, notes, company, location, image, qr, altBarcode, assignedTo, warrantyMonths, warrantyExpires, lastAuditDate, nextAuditDate, deletedAt, age, lastCheckout, lastCheckin, expectedCheckin, purchaseCost, checkinCounter, checkoutCounter, requestsCounter, userCanCheckout, bookValue, customFields, availableActions
        case assetTag = "asset_tag"
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
//        case warrantyMonths = "warranty_months"
//        case warrantyExpires = "warranty_expires"
    }
    
//    enum CodingKeys: String, CodingKey {
//        case id, name, serial, model, byod, requestable, eol, notes, company, location, image, qr, age, category, manufacturer,supplier
//        case altBarcode = "alt_barcode"
//        case assignedTo = "assigned_to"
//        case warrantyMonths = "warranty_months"
//        case warrantyExpires = "warranty_expires"
//        case lastAuditDate = "last_audit_date"
//        case nextAuditDate = "next_audit_date"
//        case deletedAt = "deleted_at"
//        case lastCheckout = "last_checkout"
//        case lastCheckin = "last_checkin"
//        case expectedCheckin = "expected_checkin"
//        case purchaseCost = "purchase_cost"
//        case checkinCounter = "checkin_counter"
//        case checkoutCounter = "checkout_counter"
//        case requestsCounter = "requests_counter"
//        case userCanCheckout = "user_can_checkout"
//        case bookValue = "book_value"
//        case customFields = "custom_fields"
//        case availableActions = "available_actions"
//        case assetTag = "asset_tag"
//        case modelNumber = "model_number"
//        case assetEolDate = "asset_eol_date"
//        case statusLabel = "status_label"
//        case orderNumber = "order_number"
//        case rtdLocation = "rtd_location"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case purchaseDate = "purchase_date"
//    }
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
