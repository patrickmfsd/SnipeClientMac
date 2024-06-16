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
            #if os(iOS)
            AssetListView()
            #else
            AssetTableView()
            #endif
        }
        .navigationTitle("All Assets")
    }
}

struct AssetCategoryListView: View {
    @StateObject private var viewModel = SnipeAPIService()
    
    var body: some View {
        Group {
            ForEach(viewModel.categoryItem) { category in
                VStack {
                    Text(category.name)
                    Text("\(category.assetsCount)")
                }
            }
        }
        .onAppear {
            viewModel.fetchCategories(category: "Asset")
            print(viewModel.hardwareItems)
        }
    }
}

#Preview {
    AssetNavigationStack()
}

