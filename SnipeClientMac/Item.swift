//
//  Item.swift
//  SnipeClientMac
//
//  Created by Patrick Mifsud on 29/5/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
