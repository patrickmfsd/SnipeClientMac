//
//  Users.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 29/5/2024.
//

import Foundation

struct UserResponse: Codable {
    let total: Int
    let rows: [User]
}

struct User: Codable, Identifiable {
    let id: Int
    let avatar: String
    let name: String
    let firstName: String
    let lastName: String
    let username: String
    let remote: Bool
    let locale: String
    let employeeNum: String
    let manager: String?
    let jobtitle: String
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
    let location: UserLocation?
    let notes: String?
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
    let createdAt: UserDateTimeInfo
    let updatedAt: UserDateTimeInfo
    let startDate: String?
    let endDate: String?
    let lastLogin: String?
    let deletedAt: String?
    let availableActions: UserAvailableActions
    let groups: [UserGroup]?
}

struct UserDepartment: Codable {
    let id: Int
    let name: String
}

struct UserLocation: Codable {
    let id: Int
    let name: String
}

struct UserPermissions: Codable {
    let assetsView: String
    
    enum CodingKeys: String, CodingKey {
        case assetsView = "assets.view"
    }
}

struct UserCompany: Codable {
    let id: Int
    let name: String
}

struct UserDateTimeInfo: Codable {
    let datetime: String
    let formatted: String
}

struct UserAvailableActions: Codable {
    let update: Bool
    let delete: Bool
    let clone: Bool
    let restore: Bool
}

struct UserGroup: Codable {
    let id: Int
    let name: String
}
