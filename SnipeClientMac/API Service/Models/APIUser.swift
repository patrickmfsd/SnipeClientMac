//
//  APIUser.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 21/10/2024.
//


import Foundation

// MARK: - User
struct APIUser: Codable {
    let id: Int
    let avatar: String
    let name: String
    let firstName: String
    let lastName: String
    let username: String
    let locale: String
    let employeeNum: String
    let manager: String?
    let jobTitle: String
    let phone: String
    let website: String?
    let address: String
    let city: String
    let state: String
    let country: String
    let zip: String
    let email: String
    let department: Department
    let location: Location
    let notes: String
    let permissions: Permissions
    let activated: Bool
    let ldapImport: Bool
    let twoFactorActivated: Bool
    let twoFactorEnrolled: Bool
    let assetsCount: Int
    let licensesCount: Int
    let accessoriesCount: Int
    let consumablesCount: Int
    let company: Company
    let createdAt: DateTime
    let updatedAt: DateTime
    let lastLogin: DateTime?
    let deletedAt: DateTime?
    let availableActions: AvailableActions
    let groups: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, avatar, name
        case firstName = "first_name"
        case lastName = "last_name"
        case username, locale
        case employeeNum = "employee_num"
        case manager, jobTitle = "jobtitle"
        case phone, website, address, city, state, country, zip, email
        case department, location, notes, permissions, activated
        case ldapImport = "ldap_import"
        case twoFactorActivated = "two_factor_activated"
        case twoFactorEnrolled = "two_factor_enrolled"
        case assetsCount = "assets_count"
        case licensesCount = "licenses_count"
        case accessoriesCount = "accessories_count"
        case consumablesCount = "consumables_count"
        case company, createdAt = "created_at"
        case updatedAt = "updated_at"
        case lastLogin = "last_login"
        case deletedAt = "deleted_at"
        case availableActions = "available_actions"
        case groups
    }
}

// MARK: - Department
struct Department: Codable {
    let id: Int
    let name: String
}

// MARK: - Location
struct Location: Codable {
    let id: Int
    let name: String
}

// MARK: - Permissions
struct Permissions: Codable {
    let superuser: String
}

// MARK: - Company
struct Company: Codable {
    let id: Int
    let name: String
}

// MARK: - DateTime
struct DateTime: Codable {
    let datetime: String
    let formatted: String
}

// MARK: - AvailableActions
struct AvailableActions: Codable {
    let update: Bool
    let delete: Bool
    let clone: Bool
    let restore: Bool
}
