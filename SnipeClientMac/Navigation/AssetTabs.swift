//
//  AssetTabs.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 8/22/24.
//

import SwiftUI

enum AssetTabs: Int, Equatable, Hashable, Identifiable, CaseIterable {
    case hardware
    case components
    case consumables
    case accessories
    
    var id: Int {
        rawValue
    }
    
    var name: String {
        switch self {
            case .hardware: String(
                localized: "Hardware",
                comment: "Tab title"
            )
            case .consumables: String(
                localized: "Consumables",
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
        }
    }
        
    var tab: Tabs {
        switch self {
            case .hardware, .components, .consumables, .accessories:
                    .assets(self)
        }
    }
    
    var icon: String {
        switch self {
            case .hardware: "laptopcomputer.and.iphone"
            case .components: "cpu"
            case .consumables: "drop.halffull"
            case .accessories: "cube.box"
        }
    }
    
    var customizationID: String {
        return "com.patrickmfsd.snipeITClient." + self.name
    }
    
    static var assetsList: [AssetTabs] {
        [.hardware, .components, .consumables, .accessories]
    }
    

    static func findAssets(from id: Int) -> AssetTabs? {
        AssetTabs.allCases.first { $0.id == id }
    }
}
