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

        test.addNewItem(newItem: TodoItem(id: "hardcode_id", text: "Hello!", importance: .low, deadline: nil, isDone: true, createdOn: Date(), changedOn: nil))
        test.addNewItem(newItem: TodoItem(id: nil, text: "Salualut Salut Salut Salut Sal!", importance: .medium, deadline: Date(), isDone: false, createdOn: Date(), changedOn: nil))
        test.addNewItem(newItem: TodoItem(id: "lll", text: "Salut S", importance: .low, deadline: Date(), isDone: false, createdOn: Date(), changedOn: nil))
        test.addNewItem(newItem: TodoItem(id: "ll2", text: "Salut S", importance: .high, deadline: Date(), isDone: false, createdOn: Date(), changedOn: nil))

        _ = test.saveAllToJSON(fileName: "testFile", fileExtension: "json")


    }


}

