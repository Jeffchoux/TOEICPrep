//
//  Item.swift
//  TOEICPrep
//
//  Created by JF CHOUX on 23/11/2025.
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
