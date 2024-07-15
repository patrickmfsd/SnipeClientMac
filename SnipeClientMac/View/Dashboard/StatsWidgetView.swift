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
                .foregroundColor(.blue)
            Text(label)
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
