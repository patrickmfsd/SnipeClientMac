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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    
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
            .customizationBehavior(.disabled, for: .sidebar, .tabBar)
            .defaultVisibility(.visible, for: .sidebar, .tabBar)
            
            
            Tab(
                Tabs.assets.name,
                systemImage: Tabs.assets.symbol,
                value: .assets
            ) {
                AssetNavigationStack()
            }
            .customizationID(Tabs.assets.customizationID)
            .customizationBehavior(.disabled, for: .sidebar, .tabBar)
            .defaultVisibility(.visible, for: .sidebar, .tabBar)
            
            Tab(
                Tabs.users.name,
                systemImage: Tabs.users.symbol,
                value: .users
            ) {
                UsersNavigationStack()
            }
            .customizationID(Tabs.users.customizationID)
            .customizationBehavior(.automatic, for: .sidebar, .tabBar)
            .defaultVisibility(.hidden, for: .tabBar)
            
            
            Tab(
                Tabs.components.name,
                systemImage: Tabs.components.symbol,
                value: .components
            ) {
                ComponentsNavigationStack()
            }
            .customizationID(Tabs.components.customizationID)
            .customizationBehavior(.disabled, for: .sidebar, .tabBar)
            .defaultVisibility(.visible, for: .sidebar)
            .defaultVisibility(.hidden, for: .tabBar)
            
            Tab(
                Tabs.consumables.name,
                systemImage: Tabs.consumables.symbol,
                value: .consumables
            ) {
                ConsumablesNavigationStack()
            }
            .customizationID(Tabs.consumables.customizationID)
            .customizationBehavior(.disabled, for: .sidebar, .tabBar)
            .defaultVisibility(.visible, for: .sidebar)
            .defaultVisibility(.hidden, for: .tabBar)
        }
        .tabViewStyle(.sidebarAdaptable)
        #if !os(macOS) && !os(tvOS)
        .tabViewCustomization($tabViewCustomization)
        #endif
    }
}

#Preview {
    SnipeClientTabs()
}
