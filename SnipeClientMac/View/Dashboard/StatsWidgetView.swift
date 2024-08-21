//
//  StatsWidgetView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 15/7/2024.
//

import SwiftUI

struct StatsWidgetView: View {
    @StateObject private var service = SnipeAPIService()

    var body: some View {
        GroupBox {
            HStack(spacing: 5) {
                Spacer()
                StatsWidgetCard(label: "Hardware", value: service.hardwareTotal)
                Divider()
                StatsWidgetCard(label: "Users", value: service.userTotal)
                Divider()
                StatsWidgetCard(label: "Maintenances", value: service.maintenancesTotal)
                Divider()
                StatsWidgetCard(label: "Components", value: service.componentsTotal)
                Divider()
                StatsWidgetCard(label: "Consumables", value: service.consumablesTotal)
                Divider()
                StatsWidgetCard(label: "Accessories", value: service.accessoriesTotal)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
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

struct StatsWidgetCard: View {
    var label: String
    var value: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("\(value)")
                .font(.system(size: 30, weight: .semibold))
            Text(label)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(width: 150, height: 100)
    }
}

#Preview {
    StatsWidgetCard(label: "Assets", value: 100)
}

#Preview {
    StatsWidgetView()
}
