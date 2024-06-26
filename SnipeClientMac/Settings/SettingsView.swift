//
//  SettingsView.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 29/5/2024.
//

import SwiftUI

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, api
    }

    var body: some View {
        #if os(macOS)
        tabView
        #else
        listView
        #endif
    }
    
    var listView: some View {
        List {
            NavigationLink(destination: APISettingsView()) {
                Label("API Connection", systemImage: "link")
            }
        }
        .navigationTitle("Settings")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
    
    var tabView: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
            APISettingsView()
                .tabItem {
                    Label("API Connection", systemImage: "link")
                }
                .tag(Tabs.api)
        }
        .padding(20)
        .frame(width: 550, height: 400)
    }
}

struct APISettingsView: View {
    @AppStorage("apiURL") var apiURL = DefaultSettings.apiURL
    @AppStorage("apiKey") var apiKey = DefaultSettings.apiKey
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .center) {
                    Text("API Settings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 15)
                    Text("To access your asset database, you'll need to generate an API key that will be associated with your user.")
                        .multilineTextAlignment(.center)
                    Link(destination: URL(string: "https://snipe-it.readme.io/reference/generating-api-tokens")!, label: {
                        Text("Learn more...")
                    })
                }
            }
            Section {
                TextField("URL", text: $apiURL)
                    .textContentType(.URL)
                TextField("API Key", text: $apiKey, axis: .vertical)
                    .lineLimit(8, reservesSpace: true)
            }
        }
        .formStyle(.grouped)
        .navigationTitle("API Settings")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

struct GeneralSettingsView: View {
    var body: some View {
        Form {
            Section {
                Text("Default Sort")
            }
            Section {
                Text("Placeholder")
            }
        }
        .formStyle(.grouped)
    }
}

#Preview {
    SettingsView()
}
