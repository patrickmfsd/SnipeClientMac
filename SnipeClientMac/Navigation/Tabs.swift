//
//  Tabs.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 15/7/2024.
//

import SwiftUI

/// A description of the tabs that the app can present.
enum Tabs: Equatable, Hashable, Identifiable {
    case search
    case dashBoard
    case asset
    case assets(AssetTabs)
    case maintenance
    case users
    case settings
    
    var id: Int {
        switch self {
            case .search: 2000
            case .dashBoard: 2001
            case .maintenance: 2002
            case .users: 2003
            case .settings: 2004
            case .asset: 2005
            case .assets(let asset): asset.id
        }
    }
    
    var name: String {
        switch self {
            case .search: String(
                localized: "Search",
                comment: "Tab title"
            )
            case .dashBoard: String(
                localized: "Dashboard",
                comment: "Tab title"
            )
            case .users: String(
                localized: "Users",
                comment: "Tab title"
            )
            case .maintenance: String(
                localized: "Maintenance",
                comment: "Tab title"
            )
            case .settings: String(
                localized: "Settings",
                comment: "Tab title"
            )
            case .assets(_): String(
                localized: "Assets",
                comment: "Tab title"
            )
            case .asset: String(
                localized: "Assets",
                comment: "Tab title"
            )
        }
    }
    
    var customizationID: String {
        return "com.patrickmfsd.snipeITClient." + self.name
    }
    
    var symbol: String {
        switch self {
            case .search: "magnifyingglass"
            case .dashBoard: "chart.bar"
            case .maintenance: "hammer"
            case .users: "person.2"
            case .settings: "gear"
            case .assets(_): "laptopcomputer.and.iphone"
            case .asset: "laptopcomputer.and.iphone"

        }
    }
    
    var isSecondary: Bool {
        switch self {
            case .dashBoard,.assets(_), .users, .search:
                false
            case .maintenance, .settings, .asset:
                true
        }
    }
}
