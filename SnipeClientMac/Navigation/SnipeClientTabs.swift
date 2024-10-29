    //
    //  TabView.swift
    //  SnipeManager
    //
    //  Created by Patrick Mifsud on 15/7/2024.
    //

import SwiftUI

struct SnipeClientTabs: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    /// Keep track of tab view customizations in app storage.
    #if !os(macOS) && !os(tvOS)
    @AppStorage("sidebarCustomizations") var tabViewCustomization: TabViewCustomization
    #endif
    
    @StateObject private var service = SnipeAPIService()
    
    @Namespace private var namespace
    @State private var selectedTab: Tabs = .dashBoard
    
    @State private var searchText: String = ""
    
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
            
            
            Tab(value: .search, role: .search) {
                Text("This view is intentionally blank")
            }
            .customizationID(Tabs.search.customizationID)
            #if !os(macOS) && !os(tvOS)
            .customizationBehavior(.disabled, for: .sidebar, .tabBar)
            #endif
            
            #if !os(visionOS)
                TabSection {
                    ForEach(AssetTabs.assetsList) { asset in
                        Tab(
                            asset.name,
                            systemImage: asset.icon,
                            value: Tabs.assets(asset)
                        ) {
                            switch asset {
                                case .hardware:
                                    AssetNavigationStack()

                                case .components:
                                    ComponentsNavigationStack()

                                case .consumables:
                                    ConsumablesNavigationStack()

                                case .accessories:
                                    AccessoriesNavigationStack()
                            }
                        }
                        .customizationID(asset.customizationID)
                    }
                } header: {
                    Label("Assets", systemImage: "laptopcomputer.and.iphone")
                }
                .customizationID(Tabs.assets(.hardware).name)
                #if !os(macOS) && !os(tvOS)
                // Prevent the tab from appearing in the tab bar by default.
                .defaultVisibility(.hidden, for: .tabBar)
                .hidden(horizontalSizeClass == .compact)
                #endif
            #endif
            
            #if os(iOS)
            if horizontalSizeClass == .compact {
                Tab(
                    Tabs.asset.name,
                    systemImage: Tabs.asset.symbol,
                    value: .asset
                ) {
                    AssetNavigationStack()
                }
                .customizationID(Tabs.asset.customizationID)
                #if !os(macOS) && !os(tvOS)
                .customizationBehavior(.automatic, for: .sidebar, .tabBar)
                .defaultVisibility(.hidden, for: .tabBar)
                #endif
            }
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
            if horizontalSizeClass == .regular {
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
            }
            #endif
        }
        .searchable(text: $searchText, placement: .sidebar)
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
            service.fetchAPIUserDetails()
        }
    }
}



#Preview {
    SnipeClientTabs()
}
