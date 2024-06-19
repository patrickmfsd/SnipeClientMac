//
//  AppScreen.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 9/4/2024.
//  Copyright © 2024 Patrick Mifsud. All rights reserved.
//

import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    /// The value for the ``Dashboard``.
    case dashboard
    /// The value for the ``Assets``.
    case assets
    /// The value for the ``Components``.
    case components
    /// The value for the ``Consumables``.
    case consumables
    /// The value for the ``Accessories``.
    case accessories
    /// The value for the ``Maintenance``.
    case maintenance
    /// The value for the ``User``.
    case users
    
    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
            case .dashboard:
                Label("Dashboard", systemImage: "gauge.with.dots.needle.67percent")
            case .assets:
                Label("Assets", systemImage: "laptopcomputer.and.iphone")
            case .users:
                Label("Users", systemImage: "person.2")
            case .components:
                Label("Components", systemImage: "cpu")
            case .consumables:
                Label("Consumables", systemImage: "drop.halffull")
            case .accessories:
                Label("Accessories", systemImage: "cube.box")
            case .maintenance:
                Label("Maintenance", systemImage: "screwdriver")

        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
            case.dashboard:
                DashboardNavigationStack()
            case.assets:
                AssetNavigationStack()
            case.users:
                UsersNavigationStack()
            case .components:
                ComponentsNavigationStack()
            case .consumables:
                EmptyView()
            case .accessories:
                EmptyView()
            case .maintenance:
                MaintenancesNavigationStack()
        }
    }
}
