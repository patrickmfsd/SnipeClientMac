//
//  Users.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 29/5/2024.
//

import Foundation

import Foundation

struct UserResponse: Codable {
    let total: Int
    let rows: [User]
}

struct User: Codable, Identifiable {
    let id: Int
    let avatar: URL
    let name: String
    let firstName: String
    let lastName: String
    let username: String
    let remote: Bool
    let locale: String
    let employeeNum: String
    let manager: String?
    let jobTitle: String
    let vip: Bool
    let phone: String
    let website: String?
    let address: String
    let city: String
    let state: String
    let country: String
    let zip: String
    let email: String
    let department: UserDepartment
    let location: String?
    let notes: String
    let permissions: UserPermissions
    let activated: Bool
    let autoassignLicenses: Bool
    let ldapImport: Bool
    let twoFactorEnrolled: Bool
    let twoFactorOptin: Bool
    let assetsCount: Int
    let licensesCount: Int
    let accessoriesCount: Int
    let consumablesCount: Int
    let managesUsersCount: Int
    let managesLocationsCount: Int
    let company: UserCompany
    let createdBy: String?
    let createdAt: UserTimestamp
    let updatedAt: UserTimestamp
    let startDate: String?
    let endDate: String?
    let lastLogin: String?
    let deletedAt: String?
    let availableActions: UserAvailableActions
    let groups: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case avatar
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case username
        case remote
        case locale
        case employeeNum = "employee_num"
        case manager
        case jobTitle = "jobtitle"
        case vip
        case phone
        case website
        case address
        case city
        case state
        case country
        case zip
        case email
        case department
        case location
        case notes
        case permissions
        case activated
        case autoassignLicenses = "autoassign_licenses"
        case ldapImport = "ldap_import"
        case twoFactorEnrolled = "two_factor_enrolled"
        case twoFactorOptin = "two_factor_optin"
        case assetsCount = "assets_count"
        case licensesCount = "licenses_count"
        case accessoriesCount = "accessories_count"
        case consumablesCount = "consumables_count"
        case managesUsersCount = "manages_users_count"
        case managesLocationsCount = "manages_locations_count"
        case company
        case createdBy = "created_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case startDate = "start_date"
        case endDate = "end_date"
        case lastLogin = "last_login"
        case deletedAt = "deleted_at"
        case availableActions = "available_actions"
        case groups
    }
}

struct UserDepartment: Codable {
    let id: Int
    let name: String
}

struct UserPermissions: Codable {
    let superuser: String
}

struct UserCompany: Codable {
    let id: Int
    let name: String
}

struct UserTimestamp: Codable {
    let datetime: String
    let formatted: String
}

struct UserAvailableActions: Codable {
    let update: Bool
    let delete: Bool
    let clone: Bool
    let restore: Bool
}
