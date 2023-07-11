//
//  TasksLaunching.swift
//  ToDoList
//
//  Created by Aliya on 24.06.2023.
//

import Foundation

enum UpdateActions {
    case delete
    case update
}

final class TasksLaunching {

    private let fileName = "testFile"
    private let fileExtension = "json"
    var cache: FileCache

    init() {
        cache = FileCache()
        if !cache.saveAllFromJSON(fileName: fileName, fileExtension: fileExtension) {
            print("saving error")
        }
    }


    func updateCache(item: TodoItem, action: UpdateActions) {
        DispatchQueue.global().sync {
            if action == .delete {
                cache.deleteItemBy(id: item.id)
            } else if action == .update {
                cache.addNewItem(newItem: item)
            }
        }
        _ = cache.saveAllToJSON(fileName: fileName, fileExtension: fileExtension)
    }

    func numberOfDoneTasks() -> Int {
        cache.toDoItems.values.filter { $0.isDone == true }.count
    }

    static func programStart() {
        
        let test = FileCache()
        test.addNewItem(id: "hardcode_id", text: "Hello!", importance: .low, deadline: Date(), isDone: true)
        test.addNewItem(id: nil, text: "Salut Salut Salut Salut v Salut Salut v v Salut Salut Salut Salut Salut Salut Salut Salut Salut Salut Salut !", importance: .low, deadline: Date(), isDone: false)
        test.addNewItem(id: "lll", text: "Salut S", importance: .low, deadline: Date(), isDone: false)
        test.addNewItem(id: "ll2", text: "Salut S", importance: .high, deadline: Date(), isDone: false)
//        test.addNewItem(id: "ll3", text: "Salut S", importance: .low, deadline: Date(), isDone: false)
//        test.addNewItem(id: "ll4", text: "Salut S", importance: .low, deadline: Date(), isDone: false)
//        test.addNewItem(id: "lll5", text: "Salut S", importance: .low, deadline: Date(), isDone: false)
//        test.addNewItem(id: "lll6", text: "Salut S", importance: .low, deadline: Date(), isDone: false)
//        test.addNewItem(id: "lll67", text: "Salut S", importance: .low, deadline: Date(), isDone: false)
//        test.addNewItem(id: "lll677", text: "Salut S", importance: .low, deadline: Date(), isDone: false)
//        test.addNewItem(id: "lll676", text: "Salut S", importance: .low, deadline: Date(), isDone: false)
//        test.addNewItem(id: "lll674", text: "Salut S", importance: .low, deadline: Date(), isDone: false)
//        test.addNewItem(id: "lll675", text: "Salut S", importance: .low, deadline: Date(), isDone: false)
        _ = test.saveAllToJSON(fileName: "testFile", fileExtension: "json")


    }


}

