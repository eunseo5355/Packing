//
//  DataManager.swift
//  Packing
//
//  Created by 배은서 on 2023/08/30.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    var categoryList: [Place] = [
        Place(title: "제주도", luggage: [Luggage(title: "세면도구", itemList: [Item(title: "치약", didPack: false), Item(title: "칫솔", didPack: false)])]),
        Place(title: "수영장", luggage: [Luggage(title: "세면도구", itemList: [Item(title: "치약", didPack: false), Item(title: "칫솔", didPack: false)])]),
        Place(title: "유럽", luggage: [Luggage(title: "세면도구", itemList: [Item(title: "치약", didPack: false), Item(title: "칫솔", didPack: false)])]),
        Place(title: "제주도", luggage: [Luggage(title: "세면도구", itemList: [Item(title: "치약", didPack: false), Item(title: "칫솔", didPack: false)])]),
        Place(title: "제주도", luggage: [Luggage(title: "세면도구", itemList: [Item(title: "치약", didPack: false), Item(title: "칫솔", didPack: false)])])
    ]
    
    func addCategory(_ category: Place) {
        categoryList.insert(category, at: 0)
    }
}
