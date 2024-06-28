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
        VStack(alignment: .leading, spacing: 5) {
            Text("Categories \(service.categoryTotal)")
                .font(.headline)
            ForEach(service.categoryItem) { category in
                HStack {
                    Text(category.categoryType)
                    Spacer()
                    Text("\(category.assetsCount)")
                }
            }
        }
        .onAppear {
            service.fetchCategories()
        }
    }
}

struct AssetsView: View {
    @StateObject private var service = SnipeAPIService()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                NavigationLink(destination: AssetListView().navigationTitle("Hardware")) {
                    FeaturedNavigation(symbol: "laptopcomputer.and.iphone", color: .blue, label: "Hardware", count: "\(service.hardwareTotal)")
                }
                NavigationLink(destination: EmptyView().navigationTitle("Accessories")) {
                    FeaturedNavigation(symbol: "cube.box", color: .blue, label: "Accessories")
                }
            }
            HStack {
                NavigationLink(destination: ComponentsListView().navigationTitle("Components")) {
                    FeaturedNavigation(symbol: "cpu", color: .green, label: "Components")
                }
                NavigationLink(destination: EmptyView().navigationTitle("Consumables")) {
                    FeaturedNavigation(symbol: "drop.halffull", color: .orange, label: "Consumables")
                }
            }
            AssetCategoryListView()
            Spacer()
        }
        .padding()
        .navigationTitle("Assets")
        .onAppear {
            service.fetchHardware()
        }
        .refreshable {
            service.fetchHardware()
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

#Preview {
    AssetNavigationStack()
}

