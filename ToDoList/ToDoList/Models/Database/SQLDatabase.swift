//
//  SQLDatabase.swift
//  ToDoList
//
//  Created by Aliya on 12.07.2023.
//
import Foundation
import SQLite
import spm

enum DatabaseError: Error {
    case pathError
}

final class SQLDatabase {

    let path: String
    let db: Connection

    let todoList = Table("todoList")
    let id = Expression<String>("id")
    let text = Expression<String>("text")
    let importance = Expression<String>("importance")
    let deadline = Expression<Date?>("deadline")
    let isDone = Expression<Bool>("isDone")
    let createdOn = Expression<Date>("createdOn")
    let changedOn = Expression<Date?>("changedOn")


    init() throws {
        do {
            guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
                throw DatabaseError.pathError
            }
            self.path = path
            self.db = try Connection("\(path)/db.todoList")
        } catch {
            print("Error: \(error)")
            throw error
        }
    }

    //MARK: - Change one by one

    func insertOne(item: TodoItem) throws -> Int {
        do {
            let itemToInsert = todoList.insert(id <- item.id,
                                               text <- item.text,
                                               importance <- item.importance.rawValue,
                                               deadline <- item.deadline,
                                               isDone <- item.isDone,
                                               createdOn <- item.createdOn,
                                               changedOn <- item.changedOn)
            return try Int(db.run(itemToInsert))
        } catch {
            throw error
        }
    }

    func updateOne(item: TodoItem) throws {
        do {
            let itemToUpdate = todoList.filter(id == item.id)
            let updates = itemToUpdate.update(text <- item.text,
                                              importance <- item.importance.rawValue,
                                              deadline <- item.deadline,
                                              isDone <- item.isDone,
                                              createdOn <- item.createdOn,
                                              changedOn <- item.changedOn)
            try db.run(updates)
        } catch {
            throw error
        }
    }

    func deleteOneById(id: String) throws -> Int {
        do {
            let itemToDelete = self.todoList.filter(self.id == id)
            return try db.run(itemToDelete.delete())
        } catch {
            throw error
        }
    }

    //MARK: - Replace all

    func recreateDatabase() throws {
        do {
            try db.run(todoList.drop())
            try db.run(todoList.create { table in
                table.column(id, primaryKey: true)
                table.column(text)
                table.column(importance)
                table.column(deadline)
                table.column(isDone)
                table.column(createdOn)
                table.column(changedOn)
            })
        } catch {
            throw error
        }
    }

    func replaceOne(string: String) throws {
        do {
            let command = "REPLACE INTO todoList (id, text, importance, deadline, isDone, createdOn, changedOn) VALUES" + string
            try db.execute(command)
        } catch {
            throw error
        }
    }

    //MARK: - Print path

    static func printPath() {
        do {
            guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
                throw DatabaseError.pathError
            }
            print("path is", path)
        } catch {
            print("Error: \(error)")
        }
    }
}
