//
//  NetworkTodoItem.swift
//  ToDoList
//
//  Created by Aliya on 05.07.2023.
//

import Foundation
import spm

struct HTTPRequestBody: Codable {
    let status: String
    let list: [NetworkTodoItem]

    init(items: [TodoItem]) {
        self.status = "ok"
        var list = [NetworkTodoItem]()
        for item in items {
            list.append(NetworkTodoItem(item: item))
        }
        self.list = list
    }
}

struct Test: Codable {

    let element: NetworkTodoItem
    init(element: NetworkTodoItem) {
        
        self.element = element
    }
}

struct HTTPBody: Codable {
    let status: String
    let list: [NetworkTodoItem]?
    let element: NetworkTodoItem?
    let revision: Int32?

//    init(items: [TodoItem]) {
//        self.status = "ok"
//        var list = [NetworkTodoItem]()
//        for item in items {
//            list.append(NetworkTodoItem(item: item))
//        }
//        self.list = list
//        self.revision = nil
//    }
}


struct NetworkTodoItem: Codable {
    let id: String
    let text: String
    let importance: String
    var deadline: Int64?
    let isDone: Bool
    let createdOn: Int64
    var changedOn: Int64?
//    let color: String?
    let lastUpdatedBy = "A"

    init(item: TodoItem) {
        self.id = item.id
        self.text = item.text
        self.importance = item.importance.rawValue
//        self.deadline = item.deadline?.timeIntervalSince1970 ?? TimeInterval(item.deadline!.timeIntervalSince1970)
        self.deadline = item.deadline == nil ? nil : Int64(item.deadline!.timeIntervalSince1970)
//        self.changedOn = item.deadline == nil ? nil : Int64(item.deadline!.timeIntervalSince1970)
        self.isDone = item.isDone
        self.createdOn = Int64(item.createdOn.timeIntervalSince1970)
//        self.changedOn = item.changedOn?.timeIntervalSince1970 ?? TimeInterval(item.changedOn!.timeIntervalSince1970)
        self.changedOn = item.changedOn == nil ? nil : Int64(item.changedOn!.timeIntervalSince1970)
//        self.color = "FFFFFF"
    }

    enum CodingKeys: String, CodingKey {
        case id
        case text
        case importance
        case deadline
        case isDone = "done"
        case createdOn = "created_at"
        case changedOn = "changed_at"
//        case color
        case lastUpdatedBy = "last_updated_by"

    }
}

