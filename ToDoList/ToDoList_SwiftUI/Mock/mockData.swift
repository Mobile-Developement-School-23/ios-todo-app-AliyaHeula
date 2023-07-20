//
//  mockData.swift
//  ToDoList_SwiftUI
//
//  Created by Aliya on 19.07.2023.
//

import Foundation

extension TodoItem: Identifiable {}

let task1 = TodoItem(id: nil, text: "Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы показать ", importance: .high, deadline: nil, isDone: true, createdOn: Date(), changedOn: Date())
let task2 = TodoItem(id: nil, text: "222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 ", importance: .low, deadline: Date() + 2, isDone: true, createdOn: Date(), changedOn: Date())
let task3 = TodoItem(id: nil, text: "111 333 444 111 333 444 111 333 444 111 333 444 111 333 444 ", importance: .high, deadline: nil, isDone: false, createdOn: Date(), changedOn: Date())
let task4 = TodoItem(id: nil, text: "222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 ", importance: .low, deadline: Date() + 2, isDone: false, createdOn: Date(), changedOn: Date())
let task5 = TodoItem(id: nil, text: "111 333 444 111 333 444 111 333 444 111 333 444 111 333 444 ", importance: .high, deadline: nil, isDone: false, createdOn: Date(), changedOn: Date())
let task6 = TodoItem(id: nil, text: "222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 ", importance: .low, deadline: Date() + 2, isDone: false, createdOn: Date(), changedOn: Date())
let task7 = TodoItem(id: nil, text: "111", importance: .high, deadline: nil, isDone: false, createdOn: Date(), changedOn: Date())
let task8 = TodoItem(id: nil, text: "222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 222 ", importance: .low, deadline: Date() + 2, isDone: false, createdOn: Date(), changedOn: Date())

var taskList = [task1, task2, task3, task4, task5, task6, task7, task8]

