//
//  Helpers.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 29/5/2024.
//

import Foundation
import SwiftUI

//MARK: - Prefers Tab Navigation
struct PrefersTabNavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var prefersTabNavigation: Bool {
        get { self[PrefersTabNavigationEnvironmentKey.self] }
        set { self[PrefersTabNavigationEnvironmentKey.self] = newValue }
    }
}

#if os(iOS)
extension PrefersTabNavigationEnvironmentKey: UITraitBridgedEnvironmentKey {
    static func read(from traitCollection: UITraitCollection) -> Bool {
        return traitCollection.userInterfaceIdiom == .phone || traitCollection.userInterfaceIdiom == .tv
    }
    
    static func write(to mutableTraits: inout UIMutableTraits, value: Bool) {
            // Do not write.
    }
}
#endif

//MARK: - Material Group box
struct MaterialGroupBox: GroupBoxStyle {
    var spacing: CGFloat
    var radius: CGFloat
    var material: Material
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, 2)
            configuration.content
        }
        .padding(spacing)
        .background(material, in: RoundedRectangle(cornerRadius: radius, style: .continuous))
    }
}
