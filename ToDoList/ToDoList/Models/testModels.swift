import Foundation

func mainmain() {
    let fileName = "lalal"
    let fileExtension = "json"
    var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    url = url.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
    print("URL: \(url)\n")
    
// Testing saving to JSON
    let test = FileCache()
    test.addNewItem(id: "hardcode_id", text: "text", importance: .low, deadline: nil, isDone: false)
    test.addNewItem(id: nil, text: "newone", importance: .high, deadline: Date(), isDone: false)
    _ = test.saveAllToJSON(fileName: fileName, fileExtension: fileExtension)
    print("Printing JSON:")
    do {
        try print("\(String(contentsOf: url))\n")
    } catch {
        print(error.localizedDescription)
    }
    
// Testing saving from JSON
    let test2 = FileCache()
    _ = test2.saveAllFromJSON(fileName: fileName, fileExtension: fileExtension)
    
    print("Printing toDoItems from collection:")
    for (_, item) in test2.toDoItems {
        print(item)
    }

}
