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
    static let defaultValue: Bool = false
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
struct CustomGroupBox: GroupBoxStyle {
    var spacing: CGFloat
    var radius: CGFloat
    var background: BackgroundType
    
    enum BackgroundType {
        case material(Material)
        case color(Color)
    }
    
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, 2)
            configuration.content
                .padding(spacing)
                .background(backgroundFill())
                .cornerRadius(radius)
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(.tertiary, lineWidth: 1)
                )
                
        }
    }
    
    private func backgroundFill() -> AnyShapeStyle {
        switch background {
            case .material(let material):
                return AnyShapeStyle(material)
            case .color(let color):
                return AnyShapeStyle(color)
        }
    }
}
