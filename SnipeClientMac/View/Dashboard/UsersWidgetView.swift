//
//  UsersWidgetView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct UsersWidgetView: View {
    @StateObject private var service = SnipeAPIService()
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 10) {
                GroupBox {
                    HStack(alignment: .center) {
                        Text("Recent Users")
                            .font(.title2)
                            .fontWeight(.medium)
                        Spacer()
                        VStack(alignment: .center) {
                            Text("\(service.userTotal)")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                            Text("Total Users")
                                .font(.footnote)
                        }
                    }
                }
                .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 20, material: .thick))
                if service.hardwareItems.isEmpty {
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 10) {
                            Image(systemName: "person.slash")
                                .font(.largeTitle)
                            Text("Users Unavailable")
                                .font(.title2)
                        }
                        Spacer()
                    }
                    .padding()
                } else {
                    ForEach(service.userItem.prefix(5)) { users in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(users.firstName) \(users.lastName)")
                                Text("Total Assets: \(users.assetsCount)")
                            }
                            Spacer()
                        }
                        .padding()
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .frame(minWidth: 300, maxWidth: 500)
                    }
                }
            }
            .onAppear {
                service.fetchHardware()
            }
            .alert(item: $service.errorMessage) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
        .groupBoxStyle(MaterialGroupBox(spacing: 10, radius: 25, material: .thin))
        .frame(maxWidth: 500)
    }
}

#Preview {
    UsersWidgetView()
}
