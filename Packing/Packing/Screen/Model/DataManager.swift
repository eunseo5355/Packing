//
//  DataManager.swift
//  Packing
//
//  Created by 배은서 on 2023/08/30.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private let key = "place"
    
    var placeList: [Place] = [
//        Place(id: 0, title: "제주도", category: [Category(title: "세면도구", itemList: [Item(title: "치약", didPack: false), Item(title: "칫솔", didPack: false)]), Category(title: "전자제품", itemList: [Item(title: "충전기", didPack: false)])]),
//        Place(id: 1, title: "수영장", category: [Category(title: "세면도구", itemList: [Item(title: "치약", didPack: false), Item(title: "칫솔", didPack: false)])]),
//        Place(id: 2, title: "유럽", category: [Category(title: "세면도구", itemList: [Item(title: "치약", didPack: false), Item(title: "칫솔", didPack: false)])]),
//        Place(id: 3, title: "제주도", category: [Category(title: "세면도구", itemList: [Item(title: "치약", didPack: false), Item(title: "칫솔", didPack: false)])]),
//        Place(id: 4, title: "제주도", category: [Category(title: "세면도구", itemList: [Item(title: "치약", didPack: false), Item(title: "칫솔", didPack: false)])])
    ]
    
    func addPlace(_ title: String) {
        let newPlace = Place(id: placeList.count + 1, title: title, category: [])
        placeList.insert(newPlace, at: 0)
        save()
    }
    
    func addCategory(_ placeIndex: Int, _ title: String) {
        placeList[placeIndex].category.append(Category(title: title, itemList: []))
        save()
    }
    
    func deleteCategory() {
        
    }
    
    func addItem(_ placeIndex: Int, _ categoryIndex: Int, title: String) {
        placeList[placeIndex].category[categoryIndex].itemList.append(Item(title: title, didPack: false))
        save()
    }
    
    func deleteItem(_ placeIndex: Int, _ categoryIndex: Int, _ itemIndex: Int) {
        placeList[placeIndex].category[categoryIndex].itemList.remove(at: itemIndex)
        save()
    }
    
    func editItemTitle(_ placeIndex: Int, _ categoryIndex: Int, _ itemIndex: Int, title: String) {
        placeList[placeIndex].category[categoryIndex].itemList[itemIndex].title = title
        save()
    }
    
    func completePacking(_ placeIndex: Int, _ categoryIndex: Int, _ itemIndex: Int) {
        placeList[placeIndex].category[categoryIndex].itemList[itemIndex].didPack.toggle()
        save()
    }
    
    func save() {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(placeList)
            UserDefaults.standard.set(encodedData, forKey: key)
        } catch {
            print("Error encoding struct: \(error)")
        }
    }
    
    func loadPlaceList() {
        if let savedData = UserDefaults.standard.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                let loadedPlace = try decoder.decode([Place].self, from: savedData)
                placeList = loadedPlace
            } catch {
                print("Error decoding struct: \(error)")
            }
        }
    }
}
