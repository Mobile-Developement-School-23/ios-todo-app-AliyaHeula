import Foundation
import UIKit
import spm

class FileCache {
    private(set) var toDoItems:[String:TodoItem] = [:]

//    func addNewItem(id: String?, text: String, importance: Importance, deadline: Date?, isDone: Bool) {
//        let newItem = TodoItem(id: id, text: text, importance: importance, deadline: deadline, isDone: isDone, createdOn: Date(), changedOn: nil)
//        toDoItems.updateValue(newItem, forKey: newItem.id)
//    }

    func addNewItem(newItem: TodoItem) {
        if toDoItems[newItem.id] == nil {
            toDoItems.updateValue(newItem, forKey: newItem.id)
            insertOneToDatabase(item: newItem)
        } else {
            toDoItems.updateValue(newItem, forKey: newItem.id)
            updateOneInDatabase(item: newItem)
        }
    }

    func deleteItemBy(id: String) {
        deleteFromDatabase(id: id)
        toDoItems.removeValue(forKey: id)
    }

//MARK: - SQL

    func save() -> Bool {
        do {
            let sqlDatabase = try SQLDatabase()
            try sqlDatabase.recreateDatabase()
            for item in self.toDoItems {
                let stringToReplace = item.value.sqlReplaceStatement
                try sqlDatabase.replaceOne(string: stringToReplace)
            }
        } catch {
            print("Error: \(error)")
            return false
        }
        return true
    }

    func load() -> Bool {
        var newList:[String:TodoItem] = [:]
        do {
            let sqlDatabase = try SQLDatabase()
//            let orderedTable = sqlDatabase.todoList.order(sqlDatabase.createdOn)
            let table = sqlDatabase.todoList
            for item in try sqlDatabase.db.prepare(table) {
                let newItem = TodoItem(id: item[sqlDatabase.id],
                                       text: item[sqlDatabase.text],
                                       importance: Importance(rawValue: item[sqlDatabase.importance]) ?? .medium,
                                       deadline: item[sqlDatabase.deadline],
                                       isDone: item[sqlDatabase.isDone],
                                       createdOn: item[sqlDatabase.createdOn],
                                       changedOn: item[sqlDatabase.changedOn])
                newList.updateValue(newItem, forKey: newItem.id)
            }
            self.toDoItems = newList
        } catch {
            print("Error: \(error)")
            return false
        }
        return true
    }

    func deleteFromDatabase(id: String) {
        do {
            let sqlDatabase = try SQLDatabase()
            if try sqlDatabase.deleteOneById(id: id) == 1 {
                print("Deleted item")
            }
        } catch {
            print("Error: \(error)")
        }
    }

    func insertOneToDatabase(item: TodoItem) {
        do {
            let sqlDatabase = try SQLDatabase()
            let rowId = try sqlDatabase.insertOne(item: item)
            print("Inserted new item with rowId: \(rowId)")
        } catch {
            print("Error: \(error)")
        }
    }

    func updateOneInDatabase(item: TodoItem) {
        do {
            let sqlDatabase = try SQLDatabase()
            let _ = try sqlDatabase.updateOne(item: item)
            print("Updated item")
        } catch {
            print("Error: \(error)")
        }
    }

//MARK: - JSON

    func saveAllToJSON(fileName: String, fileExtension: String) -> Bool {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("File saving directory is not found")
            return false
        }
        let url = directory.appendingPathComponent(fileName).appendingPathExtension(fileExtension)

        guard FileManager.default.createFile(atPath: url.path, contents: nil) else {
            print("Backup file creation error. Data is not saved.")
            return false
        }

        guard let outputStream = OutputStream(url: url, append: true) else {
            return false
        }
        outputStream.open()
        defer {
            outputStream.close()
        }
        let jsonArray = toDoItems.map { $0.value.json}
        guard JSONSerialization.isValidJSONObject(jsonArray) else {
            print("JSON object creation error. Data is not saved.")
            return false
        }
        JSONSerialization.writeJSONObject(jsonArray, to: outputStream, options: [.prettyPrinted], error: NSErrorPointer(nil))
        return true
    }

    func saveAllFromJSON (fileName: String, fileExtension: String) -> Bool {
        var downloadedList = [TodoItem]()
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("File saving directory is not found")
            return false
        }
        let url = directory.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
        guard FileManager.default.isReadableFile(atPath: url.path) else {
            print("The requested file doesn't exist or can't be read")
            return false
        }
        guard let inputStream = InputStream(url: url) else {
            return false
        }
        inputStream.open()
        defer {
            inputStream.close()
        }
        do {
            let json = try JSONSerialization.jsonObject(with: inputStream, options: []) as? [[String: Any]]
            if let itemsArray = json {
                for (item) in itemsArray {
                    if let itemToParse = TodoItem.parse(json: item) {
                        downloadedList.append(itemToParse)
                    }
                }
            } else {
                print("JSON file reading error")
            }

        } catch {
            print(error.localizedDescription)
            return false
        }
        let tmp = downloadedList.sorted {$0.createdOn > $1.createdOn}
        for item in tmp {
            self.toDoItems.updateValue(item, forKey: item.id)
        }
        return true
    }

}
