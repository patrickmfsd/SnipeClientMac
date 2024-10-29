//
//  StatsWidgetView.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 15/7/2024.
//

import SwiftUI

struct StatsWidgetView: View {
    @StateObject private var service = SnipeAPIService()
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    
    // Simplified grid definitions with more flexible sizing
    private let gridSpacing: CGFloat = 20
    private let columns = [
        GridItem(.flexible(minimum: 140), spacing: 16),
        GridItem(.flexible(minimum: 140), spacing: 16)
    ]
    
    private let rows = [
        GridItem(.flexible(minimum: 70), spacing: 80)
    ]
    
    var body: some View {
        GroupBox {
            Group {
                if prefersTabNavigation {
                    LazyVGrid(columns: columns, spacing: gridSpacing) {
                        statsCards
                    }
                } else {
                    HStack {
                        Spacer()
                        LazyHGrid(rows: rows, spacing: gridSpacing) {
                            statsCards
                        }
                        Spacer()
                    }
                }
            }
            .padding()
        }
        .onAppear {
            Task {
                fetchData()
            }
        }
    }
    
    private var statsCards: some View {
        Group {
            StatsWidgetCard(label: "Hardware", value: service.hardwareTotal)
            StatsWidgetCard(label: "Components", value: service.componentsTotal)
            StatsWidgetCard(label: "Consumables", value: service.consumablesTotal)
            StatsWidgetCard(label: "Accessories", value: service.accessoriesTotal)
            StatsWidgetCard(label: "Users", value: service.userTotal)
            StatsWidgetCard(label: "Maintenances", value: service.maintenancesTotal)
        }
    }
    
    private func fetchData() {
        service.fetchAssetMaintenances()
        service.fetchAllComponents()
        service.fetchAllConsumables()
        service.fetchAllAccessories()
    }
}

struct StatsWidgetCard: View {
    let label: String
    let value: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Text("\(value)")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.primary)
            
            Text(label)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(value) \(label)")
    }
}

#Preview {
    StatsWidgetCard(label: "Assets", value: 100)
}

#Preview {
    StatsWidgetView()
}
