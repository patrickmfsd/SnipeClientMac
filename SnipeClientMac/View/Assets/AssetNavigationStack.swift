//
//  AssetNavigationStack.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct AssetNavigationStack: View {
    var body: some View {
        NavigationStack {
            Group {
                #if os(iOS)
                AssetsView()
                #else
                AssetTableView()
                #endif
            }
            .navigationTitle("Assets")
        }
    }
}

struct AssetCategoryListView: View {
    @StateObject private var service = SnipeAPIService()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Categories")
                .font(.title3)
                .fontWeight(.medium)
            VStack(alignment: .leading, spacing: 5) {
                ForEach(service.categoryItem) { category in
                    RowView(
                        name: category.name,
                        count: "\(category.assetsCount)"
                    )
                }
            }
        }
        .padding(.top, 15)
        .onAppear {
            service.fetchCategories()
        }
    }
}

struct AssetsView: View {
    @StateObject private var service = SnipeAPIService()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    NavigationLink(
                        destination: AssetListView()
                            .navigationTitle("Hardware")
                    ) {
                        FeaturedNavigation(symbol: "laptopcomputer.and.iphone", color: .blue, label: "Hardware", count: "\(service.hardwareTotal)")
                    }
                    NavigationLink(
                        destination: AccessoriesListView()
                            .navigationTitle("Accessories")
                    ) {
                        FeaturedNavigation(symbol: "cube.box", color: .blue, label: "Accessories", count: "\(service.accessoriesTotal)")
                    }
                }
                HStack {
                    NavigationLink(
                        destination: ComponentsListView()
                            .navigationTitle("Components")
                    ) {
                        FeaturedNavigation(symbol: "cpu", color: .green, label: "Components", count: "\(service.componentsTotal)")
                    }
                    NavigationLink(
                        destination: ConsumablesListView()
                            .navigationTitle("Consumables")
                    ) {
                        FeaturedNavigation(symbol: "drop.halffull", color: .orange, label: "Consumables", count: "\(service.consumablesTotal)")
                    }
                }
                AssetCategoryListView()
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Assets")
        .onAppear {
            service.fetchHardware()
            service.fetchAllComponents()
            service.fetchAllConsumables()
            service.fetchCategories()
            service.fetchAllAccessories()
        }
        .refreshable {
            service.fetchHardware()
            service.fetchAllComponents()
            service.fetchAllConsumables()
            service.fetchCategories()
            service.fetchAllAccessories()
        }
    }
}

struct FeaturedNavigation: View {
    var symbol: String
    var type: SymbolRenderingMode?
    var color: Color
    var label: String
    var count: String?
    
    var body: some View {
        GroupBox {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 15) {
                    Image(systemName: symbol)
                        .font(.title)
                        .symbolVariant(.fill)
                        .foregroundColor(color)
                        .symbolRenderingMode(type ?? .monochrome)
                    Text(label)
                        .font(.body)
                        .foregroundColor(.primary)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }
                Spacer()
                if count != "" {
                    Text(count ?? "")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                }
            }
            .frame(height: 70)
        }
    }
}

struct RowView: View {
    var name: String
    var count: String
    
    var body: some View {
        VStack {
            Divider()
            HStack(spacing: 10) {
                Text(name)
                    .foregroundStyle(.primary)
                Spacer()
                Text(count)
                    .font(.footnote)
                    .padding(.vertical, 5)
                    .frame(width: 50)
                    .background(.tint, in: Capsule())
                Image(systemName: "chevron.right")
            }
            .padding(.vertical, 10)
            .padding(.leading, 8)
        }
    }
}

#Preview {
    AssetNavigationStack()
}

