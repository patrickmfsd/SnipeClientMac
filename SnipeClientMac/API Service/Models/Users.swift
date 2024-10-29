//
//  Users.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 29/5/2024.
//

import Foundation

struct UserResponse: Codable {
    let total: Int
    let rows: [User]
}

struct User: Codable, Identifiable, Equatable {
    let id: Int
    let avatar: String?
    let name: String
    let firstName: String
    let lastName: String?
    let username: String
    let remote: Bool?
    let locale: String?
    let employeeNum: String?
    let manager: String?
    let jobTitle: String?
    let vip: Bool?
    let phone: String?
    let website: String?
    let address: String?
    let city: String?
    let state: String?
    let country: String?
    let zip: String?
    let email: String?
    let department: UserDepartment?
    let location: Location?
    let notes: String?
    let permissions: [String: String]?
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
    let company: UserCompany?
    let createdBy: UserCreatedBy?
    let createdAt: UserTimestamp?
    let updatedAt: UserTimestamp?
    let startDate: String?
    let endDate: String?
    let lastLogin: UserTimestamp?
    let deletedAt: String?
    let availableActions: UserAvailableActions
    let groups: UserGroups?
    
    enum CodingKeys: String, CodingKey {
        case id, avatar, name, username, remote, locale, manager, notes, permissions, activated, company, startDate, endDate, deletedAt, groups
        case firstName = "first_name"
        case lastName = "last_name"
        case employeeNum = "employee_num"
        case jobTitle = "jobtitle"
        case vip, phone, website, address, city, state, country, zip, email, department, location
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
        case createdBy = "created_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case lastLogin = "last_login"
        case availableActions = "available_actions"
    }
    
    struct UserDepartment: Codable, Equatable {
        let id: Int
        let name: String
    }
    
    struct Location: Codable, Equatable {
        let id: Int
        let name: String
    }
    
    struct UserPermissions: Codable, Equatable {
        let superuser: String?
        let admin: String?
        let impt: String?
        let reportsView: String?
        let assetsView: String?
        let assetsCreate: String?
        let assetsEdit: String?
        let assetsDelete: String?
        let assetsCheckin: String?
        let assetsCheckout: String?
        let assetsAudit: String?
        let assetsViewRequestable: String?
        let accessoriesView: String?
        let accessoriesCreate: String?
        let accessoriesEdit: String?
        let accessoriesDelete: String?
        let accessoriesCheckout: String?
        let accessoriesCheckin: String?
        let consumablesView: String?
        let consumablesCreate: String?
        let consumablesEdit: String?
        let consumablesDelete: String?
        let consumablesCheckout: String?
        let licensesView: String?
        let licensesCreate: String?
        let licensesEdit: String?
        let licensesDelete: String?
        let licensesCheckout: String?
        let licensesKeys: String?
        let licensesFiles: String?
        let componentsView: String?
        let componentsCreate: String?
        let componentsEdit: String?
        let componentsDelete: String?
        let componentsCheckout: String?
        let componentsCheckin: String?
        let kitsView: String?
        let kitsCreate: String?
        let kitsEdit: String?
        let kitsDelete: String?
        let usersView: String?
        let usersCreate: String?
        let usersEdit: String?
        let usersDelete: String?
        let modelsView: String?
        let modelsCreate: String?
        let modelsEdit: String?
        let modelsDelete: String?
        let categoriesView: String?
        let categoriesCreate: String?
        let categoriesEdit: String?
        let categoriesDelete: String?
        let departmentsView: String?
        let departmentsCreate: String?
        let departmentsEdit: String?
        let departmentsDelete: String?
        let statuslabelsView: String?
        let statuslabelsCreate: String?
        let statuslabelsEdit: String?
        let statuslabelsDelete: String?
        let customfieldsView: String?
        let customfieldsCreate: String?
        let customfieldsEdit: String?
        let customfieldsDelete: String?
        let suppliersView: String?
        let suppliersCreate: String?
        let suppliersEdit: String?
        let suppliersDelete: String?
        let manufacturersView: String?
        let manufacturersCreate: String?
        let manufacturersEdit: String?
        let manufacturersDelete: String?
        let depreciationsView: String?
        let depreciationsCreate: String?
        let depreciationsEdit: String?
        let depreciationsDelete: String?
        let locationsView: String?
        let locationsCreate: String?
        let locationsEdit: String?
        let locationsDelete: String?
        let companiesView: String?
        let companiesCreate: String?
        let companiesEdit: String?
        let companiesDelete: String?
        let selfTwoFactor: String?
        let selfApi: String?
        let selfEditLocation: String?
        let selfCheckoutAssets: String?
        
        enum CodingKeys: String, CodingKey {
            case superuser, admin, impt, reportsView, assetsView, assetsCreate, assetsEdit, assetsDelete, assetsCheckin, assetsCheckout, assetsAudit, assetsViewRequestable, accessoriesView, accessoriesCreate, accessoriesEdit, accessoriesDelete, accessoriesCheckout, accessoriesCheckin, consumablesView, consumablesCreate, consumablesEdit, consumablesDelete, consumablesCheckout, licensesView, licensesCreate, licensesEdit, licensesDelete, licensesCheckout, licensesKeys, licensesFiles, componentsView, componentsCreate, componentsEdit, componentsDelete, componentsCheckout, componentsCheckin, kitsView, kitsCreate, kitsEdit, kitsDelete, usersView, usersCreate, usersEdit, usersDelete, modelsView, modelsCreate, modelsEdit, modelsDelete, categoriesView, categoriesCreate, categoriesEdit, categoriesDelete, departmentsView, departmentsCreate, departmentsEdit, departmentsDelete, statuslabelsView, statuslabelsCreate, statuslabelsEdit, statuslabelsDelete, customfieldsView, customfieldsCreate, customfieldsEdit, customfieldsDelete, suppliersView, suppliersCreate, suppliersEdit, suppliersDelete, manufacturersView, manufacturersCreate, manufacturersEdit, manufacturersDelete, depreciationsView, depreciationsCreate, depreciationsEdit, depreciationsDelete, locationsView, locationsCreate, locationsEdit, locationsDelete, companiesView, companiesCreate, companiesEdit, companiesDelete, selfTwoFactor, selfApi, selfEditLocation, selfCheckoutAssets
        }
    }
    
    struct UserCompany: Codable, Equatable {
        let id: Int?
        let name: String?
    }
    
    struct UserCreatedBy: Codable, Equatable {
        let id: Int?
        let name: String?
    }
    
    struct UserTimestamp: Codable, Equatable {
        let datetime: String?
        let formatted: String?
    }
    
    struct UserAvailableActions: Codable, Equatable {
        let update: Bool?
        let delete: Bool?
        let clone: Bool?
        let restore: Bool?
    }
    
    struct UserGroups: Codable, Equatable {
        let total: Int
        let rows: [UserGroup]?
        
        struct UserGroup: Codable, Equatable {
            let id: Int
            let name: String?
        }
    }
}
