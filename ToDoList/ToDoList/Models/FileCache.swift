import Foundation

final class FileCache {
    private(set) var toDoItems:[String:TodoItem] = [:]
    
    func addNewItem(id: String?, text: String, importance: Importance, deadline: Date?, isDone: Bool) {
        let newItem = TodoItem(id: id, text: text, importance: importance, deadline: deadline, isDone: isDone, createdOn: .now, changedOn: nil)
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
//        var jsonArray = [[String: Any]] ()
        var jsonArray = toDoItems.map { $0.value.json }
//        for (_,item) in toDoItems {
//            jsonArray.append(item.json as! [String : Any])
//        }
//        var jsonDictionary = [String: [[String: Any]]]()
//        jsonDictionary.updateValue(jsonArray, forKey: "list")
        
        guard JSONSerialization.isValidJSONObject(jsonArray) else {
            print("JSON object creation error. Data is not saved.")
            return false
        }
        JSONSerialization.writeJSONObject(jsonArray, to: outputStream, options: [.prettyPrinted], error: NSErrorPointer(nil))
        return true
    }
    
    
    func saveAllFromJSON (fileName: String, fileExtension: String) -> Bool {
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
                        self.addNewItem(newItem: itemToParse)
                    }
                }
            } else {
                print("JSON file reading error")
            }

        } catch {
            print(error.localizedDescription)
            return false
        }
        return true
    }
}


