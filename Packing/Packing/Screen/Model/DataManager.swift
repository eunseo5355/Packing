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
    
    var placeList: [Place] = []
    
    func addPlace(_ title: String) {
        let newPlace = Place(id: placeList.count + 1, title: title, category: [])
        placeList.insert(newPlace, at: 0)
        save()
    }
    
    func deletePlace(_ placeIndex: Int) {
        placeList.remove(at: placeIndex)
        save()
    }
    
    func editPlaceTitle(_ placeIndex: Int, _ title: String) {
        placeList[placeIndex].title = title
        save()
    }
    
    func addCategory(_ placeIndex: Int, _ title: String) {
        placeList[placeIndex].category.append(Category(title: title, itemList: []))
        save()
    }
    
    func deleteCategory(_ placeIndex: Int, _ categoryIndex: Int) {
        placeList[placeIndex].category.remove(at: categoryIndex)
        save()
    }
    
    func editCategoryTitle(_ placeIndex: Int, _ categoryIndex: Int, title: String) {
        placeList[placeIndex].category[categoryIndex].title = title
        save()
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
