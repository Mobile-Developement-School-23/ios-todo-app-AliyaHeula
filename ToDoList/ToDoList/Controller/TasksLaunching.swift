//
//  TasksLaunching.swift
//  ToDoList
//
//  Created by Aliya on 24.06.2023.
//

import Foundation



final class TasksLaunching {

    static let fileName = "testFile"
    static let fileExtension = "json"
    static let cache = FileCache()

    static func programStart() {
        let test = FileCache()
        test.addNewItem(id: "hardcode_id", text: "Hello!", importance: .low, deadline: nil, isDone: false)
        test.addNewItem(id: nil, text: "Salut!", importance: .high, deadline: Date(), isDone: false)
        _ = test.saveAllToJSON(fileName: fileName, fileExtension: fileExtension)
        if !cache.saveAllFromJSON(fileName: fileName, fileExtension: fileExtension) {
            print("saving error")
        }
    }
}
