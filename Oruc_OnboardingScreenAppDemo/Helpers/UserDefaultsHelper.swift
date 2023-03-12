//
//  UserDefaultsHelper.swift
//  Oruc_OnboardingScreenAppDemo
//
//  Created by Oruj Dursunzade on 09.03.23.
//

import Foundation

enum UserDefaultsKeys {
    static let USER_LOGGED_IN = "USER_LOGGED_IN"
    static let USER_CREDENTIALS = "USER_CREDENTIALS"
    static let USER_NAME = "username"
    static let USER_PASS = "password"
    static let TO_DO_ITEMS = "TO_DO_ITEMS"
}



class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    
    public var tempItemList : [ToDoListItem] = []
    
    let defaults = UserDefaults.standard
    
    // MARK: JSON data saving function from Aykhan muellim
    
    func saveObject<T: Codable>(_ object: T?, key: String) {
        if let object = object {
            if let data =
                try? JSONEncoder().encode(object) {
                UserDefaults.standard.set(data, forKey: key)
                UserDefaults.standard.synchronize()
            }
        }
    }

    func getObject<T: Codable>(_ class: T?, key: String) -> T? {
        let decoder = JSONDecoder()
        if let data =
            UserDefaults.standard.data(forKey: key),
            let object = try? decoder.decode(T.self, from: data) {
            return object
        } else {
            return nil
        }
    }
    
    // MARK: My functions
    
    func saveCredentials(_ dictionary : Dictionary<String, String>) {
        defaults.set(dictionary, forKey: UserDefaultsKeys.USER_CREDENTIALS)
    }
    
    func loadCredentials() -> Dictionary<String, String> {
        let userCredentials = defaults.object(forKey: UserDefaultsKeys.USER_CREDENTIALS) as? [String : String] ?? [:]
        return userCredentials
    }
    
    func setUserLoggedin (_ value : Bool){
        defaults.set(value, forKey: UserDefaultsKeys.USER_LOGGED_IN)
    }
    
    func getUserStatus () -> Bool{
        let userStatus = defaults.bool(forKey: UserDefaultsKeys.USER_LOGGED_IN)
        return userStatus
    }
    
    func saveNewToDoItem(item : ToDoListItem){
        tempItemList.append(item)
        DispatchQueue.main.async {
            self.saveObject(self.tempItemList, key: UserDefaultsKeys.TO_DO_ITEMS)
        }
    }
    
    func loadToDoItems () -> [ToDoListItem] {
        let myArray : [ToDoListItem] = []
        if let array = getObject(myArray, key: UserDefaultsKeys.TO_DO_ITEMS) {
            self.tempItemList = array
        }
        return tempItemList
    }
    
    func updateToDoItems(item : ToDoListItem){
        if let oldItem = tempItemList.filter({$0.itemId == item.itemId}).first {
            if let itemIndex = tempItemList.firstIndex(of: oldItem){
                tempItemList[itemIndex] = item
            }
            self.saveObject(self.tempItemList, key: UserDefaultsKeys.TO_DO_ITEMS)
        }
    }
    
    func deleteToDoItem(itemId: String){
        if let itemToBeDeleted = tempItemList.filter({$0.itemId == itemId}).first {
            if let itemIndex = tempItemList.firstIndex(of: itemToBeDeleted){
                tempItemList.remove(at: itemIndex)
            }
            self.saveObject(self.tempItemList, key: UserDefaultsKeys.TO_DO_ITEMS)
        }
    }
    
    func toDoItemsStatusFilter(status : Bool) -> [ToDoListItem]{
        let arrayToBeFiltered = loadToDoItems()
        let filteredArray = arrayToBeFiltered.filter({$0.itemStatus == status})
        return filteredArray
    }
    
    
}
