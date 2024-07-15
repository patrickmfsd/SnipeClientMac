//
//  Tabs.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 15/7/2024.
//

import SwiftUI

/// A description of the tabs that the app can present.
enum Tabs: Equatable, Hashable, Identifiable {
    case dashBoard
    case assets
    case components
    case consumables
    case accessories
    case maintenance
    case users
    case settings
    
    var id: Int {
        switch self {
            case .dashBoard: 2001
            case .assets: 2002
            case .components: 2004
            case .accessories: 2005
            case .maintenance: 2006
            case .users: 2007
            case .consumables: 2008
            case .settings: 2009
        }
    }
    
    var name: String {
        switch self {
            case .dashBoard: String(
                localized: "Dashboard",
                comment: "Tab title"
            )
            case .assets: String(
                localized: "Assets",
                comment: "Tab title"
            )
            case .components: String(
                localized: "Components",
                comment: "Tab title"
            )
            case .accessories: String(
                localized: "Accessories",
                comment: "Tab title"
            )
            case .users: String(
                localized: "Users",
                comment: "Tab title"
            )
            case .consumables: String(
                localized: "Consumables",
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
        }
    }
    
    var customizationID: String {
        return "com.patrickmfsd.snipeITClient." + self.name
    }
    
    var symbol: String {
        switch self {
            case .dashBoard: "chart.bar"
            case .assets: "laptopcomputer.and.iphone"
            case .components: "cpu"
            case .consumables: "drop.halffull"
            case .accessories: "cube.box"
            case .maintenance: "hammer"
            case .users: "person.2"
            case .settings: "gear"
        }
    }
    
    var isSecondary: Bool {
        switch self {
            case .dashBoard, .assets, .users, .settings:
                false
            case .accessories, .components, .consumables, .maintenance:
                true
        }
    }
}
