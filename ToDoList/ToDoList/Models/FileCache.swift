import Foundation
import UIKit
import spm

class FileCache {
    private(set) var toDoItems:[String:TodoItem] = [:]

    func addNewItem(id: String?, text: String, importance: Importance, deadline: Date?, isDone: Bool) {
        let newItem = TodoItem(id: id, text: text, importance: importance, deadline: deadline, isDone: isDone, createdOn: Date(), changedOn: nil)
        toDoItems.updateValue(newItem, forKey: newItem.id)
    }

    func addNewItem(newItem: TodoItem) {
        toDoItems.updateValue(newItem, forKey: newItem.id)
    }

    func deleteItemBy(id: String) {
        toDoItems.removeValue(forKey: id)
    }

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
        let tmp = downloadedList.sorted {$0.createdOn < $1.createdOn}
        for item in tmp {
            self.toDoItems.updateValue(item, forKey: item.id)
        }
        return true
    }
}

//extension FileCache {
//    public func numberOfDoneTasks() -> Int {
//        toDoItems.filter{$0.value.isDone == true}.count
//    }
//}
