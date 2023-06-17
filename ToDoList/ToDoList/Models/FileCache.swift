import Foundation

class FileCache {
    var toDoItems:[String:TodoItem]
    
    init() {
        self.toDoItems = [:]
    }
    
    func createNewItem(id: String?, text: String, importance: Importance, deadline: Date?, isDone: Bool) {
        let newItem = TodoItem(id: id, text: text, importance: importance, deadline: deadline, isDone: isDone, createdOn: .now, changedOn: nil)
        toDoItems.updateValue(newItem, forKey: newItem.id)
    }
    
    func createNewItem(newItem: TodoItem) {
        toDoItems.updateValue(newItem, forKey: newItem.id)
    }
    
    func deleteItemBy(id: String) {
        toDoItems.removeValue(forKey: id)
    }
    
    func saveAllToJSON(fileName: String, fileExtension: String) -> Bool {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        url = url.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
        
        guard FileManager.default.createFile(atPath: url.path, contents: nil) else {
            print("Backup file creation error. Data is not saved.")
            return false
        }
        
        let outputStream = OutputStream(url: url, append: true)!
        outputStream.open()
        defer {
            outputStream.close()
        }
        var jsonArray = [[String: Any]] ()
        for (_,item) in toDoItems {
            jsonArray.append(item.json as! [String : Any])
        }
        var jsonDictionary = [String: [[String: Any]]]()
        jsonDictionary.updateValue(jsonArray, forKey: "list")
        
        guard JSONSerialization.isValidJSONObject(jsonDictionary) else {
            print("JSON object creation error. Data is not saved.")
            return false
        }
        JSONSerialization.writeJSONObject(jsonDictionary, to: outputStream, options: [.prettyPrinted], error: NSErrorPointer(nil))
        return true
    }
    
    
    func saveAllFromJSON (fileName: String, fileExtension: String) -> Bool {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        url = url.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
        
        guard FileManager.default.isReadableFile(atPath: url.path) else {
            print("The requested file doesn't exist or can't be read")
            return false
        }
        let inputStream = InputStream(url: url)!
        inputStream.open()
        defer {
            inputStream.close()
        }
        do {
            let json = try JSONSerialization.jsonObject(with: inputStream, options: []) as! [String: Any]
            if let itemsArray = json["list"] as? [[String: Any]]  {
                for (item) in itemsArray {
                    if let itemToParse = TodoItem.parse(json: item) {
                        self.createNewItem(newItem: itemToParse)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return true
    }
}
