//
//  AppDetailColumn.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 11/6/2022.
//

import SwiftUI
import SwiftData

struct AppDetailColumn: View {
    var screen: AppScreen?
    
    var body: some View {
        Group {
            if let screen {
                screen.destination
            } else {
                ContentUnavailableView("Select a View", systemImage: "uiwindow.split.2x1", description: Text("Pick something from the list"))
            }
        }
        #if os(macOS)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background()
        #endif
    }
}

#Preview {
    AppDetailColumn()
//        .backyardBirdsDataContainer(inMemory: true)
}
