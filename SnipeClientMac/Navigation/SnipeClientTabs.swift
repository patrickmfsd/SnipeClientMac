    //
    //  TabView.swift
    //  SnipeClientMac
    //
    //  Created by Patrick Mifsud on 15/7/2024.
    //

import SwiftUI

struct SnipeClientTabs: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    /// Keep track of tab view customizations in app storage.
    #if !os(macOS) && !os(tvOS)
    @AppStorage("sidebarCustomizations") var tabViewCustomization: TabViewCustomization
    #endif
    
    @StateObject private var service = SnipeAPIService()
    
    @Namespace private var namespace
    @State private var selectedTab: Tabs = .dashBoard
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(
                Tabs.dashBoard.name,
                systemImage: Tabs.dashBoard.symbol,
                value: .dashBoard
            ) {
                DashboardNavigationStack()
            }
            .customizationID(Tabs.dashBoard.customizationID)
            #if !os(macOS) && !os(tvOS)
            .customizationBehavior(.disabled, for: .sidebar, .tabBar)
            .defaultVisibility(.visible, for: .sidebar, .tabBar)
            #endif
            
            Tab(
                Tabs.assets.name,
                systemImage: Tabs.assets.symbol,
                value: .assets
            ) {
                AssetNavigationStack()
            }
            .customizationID(Tabs.assets.customizationID)
            #if !os(macOS) && !os(tvOS)
            .customizationBehavior(.disabled, for: .sidebar, .tabBar)
            .defaultVisibility(.visible, for: .sidebar, .tabBar)
            #endif

            Tab(
                Tabs.users.name,
                systemImage: Tabs.users.symbol,
                value: .users
            ) {
                UsersNavigationStack()
            }
            .customizationID(Tabs.users.customizationID)
            #if !os(macOS) && !os(tvOS)
            .customizationBehavior(.automatic, for: .sidebar, .tabBar)
            .defaultVisibility(.hidden, for: .tabBar)
            #endif
            
            if !prefersTabNavigation {
                Tab(
                    Tabs.accessories.name,
                    systemImage: Tabs.accessories.symbol,
                    value: .accessories
                ) {
                    AccessoriesNavigationStack()
                }
                .customizationID(Tabs.accessories.customizationID)
                #if !os(macOS) && !os(tvOS)
                .customizationBehavior(.automatic, for: .sidebar, .tabBar)
                .defaultVisibility(.visible, for: .sidebar)
                .defaultVisibility(.hidden, for: .tabBar)
                #endif
            }
            if !prefersTabNavigation {
                Tab(
                    Tabs.components.name,
                    systemImage: Tabs.components.symbol,
                    value: .components
                ) {
                    ComponentsNavigationStack()
                }
                .customizationID(Tabs.components.customizationID)
                #if !os(macOS) && !os(tvOS)
                .customizationBehavior(.automatic, for: .sidebar, .tabBar)
                .defaultVisibility(.visible, for: .sidebar)
                .defaultVisibility(.hidden, for: .tabBar)
                #endif
            }
            if !prefersTabNavigation {
                Tab(
                    Tabs.consumables.name,
                    systemImage: Tabs.consumables.symbol,
                    value: .consumables
                ) {
                    ConsumablesNavigationStack()
                }
                .customizationID(Tabs.consumables.customizationID)
                #if !os(macOS) && !os(tvOS)
                .customizationBehavior(.automatic, for: .sidebar, .tabBar)
                .defaultVisibility(.visible, for: .sidebar)
                .defaultVisibility(.hidden, for: .tabBar)
                #endif
            }
            
            Tab(
                Tabs.maintenance.name,
                systemImage: Tabs.maintenance.symbol,
                value: .maintenance
            ) {
                MaintenancesNavigationStack()
            }
            .customizationID(Tabs.maintenance.customizationID)
            #if !os(macOS) && !os(tvOS)
            .customizationBehavior(.automatic, for: .sidebar, .tabBar)
            .defaultVisibility(.visible, for: .sidebar)
            .defaultVisibility(.hidden, for: .tabBar)
            #endif
            
            #if !os(macOS)
                Tab(
                    Tabs.settings.name,
                    systemImage: Tabs.settings.symbol,
                    value: .settings
                ) {
                    SettingsNavigationStack()
                }
                .customizationID(Tabs.settings.customizationID)
                #if !os(macOS) && !os(tvOS)
                .customizationBehavior(.automatic, for: .sidebar, .tabBar)
                .defaultVisibility(.visible, for: .sidebar)
                .defaultVisibility(.hidden, for: .tabBar)
                #endif
            #endif
        }
        .frame(minWidth: 100)
        .tabViewStyle(.sidebarAdaptable)
        #if !os(macOS) && !os(tvOS)
        .tabViewCustomization($tabViewCustomization)
        #endif
        .onAppear {
            service.fetchHardware()
            service.fetchUsers()
            service.fetchAssetMaintenances()
            service.fetchAllComponents()
            service.fetchAllConsumables()
            service.fetchAllAccessories()
        }
    }
}

#Preview {
    SnipeClientTabs()
}
