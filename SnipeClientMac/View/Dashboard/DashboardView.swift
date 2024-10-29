//
//  DashboardView.swift
//  SnipeManager
//
//  Created by Patrick Mifsud on 31/5/2024.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.prefersTabNavigation) private var prefersTabNavigation
    @Environment(\.colorScheme) private var colorScheme
    @StateObject private var service = SnipeAPIService()
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                StatsWidgetView()
                Group {
                    AssetCard()
                        .transition(.move(edge: .leading))
                    
                    UsersCard()
                        .transition(.move(edge: .trailing))
                    
                    MaintenanceCard()
                        .transition(.move(edge: .bottom))
                }
            }
            .padding()
        }
        .foregroundColor(.primary)
        .navigationTitle("Dashboard")
        .animation(.spring(response: 0.3), value: service.isLoading)
    }
    
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(.background)
                    .shadow(color: .black.opacity(0.1),
                           radius: 8, x: 0, y: 4)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .strokeBorder(.quaternary, lineWidth: 0.5)
            }
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardModifier())
    }
}

#Preview {
    DashboardView()
}
