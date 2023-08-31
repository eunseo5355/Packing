//
//  Place.swift
//  Packing
//
//  Created by 배은서 on 2023/08/29.
//

import Foundation

struct Place: Codable {
    var id: Int
    var title: String
    var category: [Category]
}
