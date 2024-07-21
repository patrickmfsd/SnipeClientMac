//
//  AssetRow.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 19/7/2024.
//

import SwiftUI

struct AssetRowView: View {
    var image: String
    var name: String
    var manufacturer: String
    var model: String
    var assetNumber: String
    var serialNumber: String
    
    var body: some View {
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .padding(5)
                    .background(.white, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
            } placeholder: {
                Image(systemName: "laptopcomputer")
                    .font(.system(size: 50))
            }
            VStack(alignment: .leading) {
                if name.isEmpty {
                    Text(assetNumber.isEmpty ? assetNumber : serialNumber)
                        .font(.headline)
                } else {
                    Text(name)
                        .font(.headline)
                }
                Text("\(manufacturer) - \(model)")
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
    }
}

#Preview {
    AssetRowView(image: "", name: "", manufacturer: "", model: "", assetNumber: "", serialNumber: "")
}
