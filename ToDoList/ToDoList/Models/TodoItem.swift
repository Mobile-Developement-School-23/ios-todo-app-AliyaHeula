import Foundation

enum Importance: String {
    case low
    case medium
    case high
}

struct TodoItem {
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let isDone: Bool
    let createdOn: Date
    let changedOn: Date?
    
    init(id: String?, text: String, importance: Importance, deadline: Date?, isDone: Bool, createdOn: Date, changedOn: Date?) {
        self.id = {
            if let id = id {
                return id
            } else {
                return UUID().uuidString
            }
        }()
        self.text = text
        self.importance = importance
        self.deadline = deadline
        self.isDone = isDone
        self.createdOn = createdOn
        self.changedOn = changedOn
    }
}

extension TodoItem {
    static func parse(json: Any) -> TodoItem? {
        
        guard let dictionary = json as? [String: Any] else {
            return nil
        }
        guard let id = dictionary["id"] as? String,
              let text = dictionary["text"] as? String,
              let isDone = dictionary["isDone"] as? Bool,
              let createdOn = dictionary["createdOn"] as? TimeInterval,
              let importanceCheck = dictionary["importance"],
              let deadlineCheck = dictionary["deadline"],
              let changedOnCheck = dictionary["changedOn"] else {
            return nil
        }
        
        //Check importance, deadline and changedOn parameters for nil:
        var importance: Importance
        if importanceCheck is NSNull {
            importance = .medium
        } else if let str = importanceCheck as? String,
                  let tmp = Importance(rawValue: str) {
            importance = tmp
        } else {
            return nil
        }
        
        var deadline: Date?
        if deadlineCheck is NSNull {
            deadline = nil
        } else if let tmp = deadlineCheck as? TimeInterval {
            deadline = Date(timeIntervalSince1970: tmp)
        } else {
            return nil
        }
        var changedOn: Date?
        if changedOnCheck is NSNull {
            changedOn = nil
        } else if let tmp = changedOnCheck as? TimeInterval {
            deadline = Date(timeIntervalSince1970: tmp)
        } else {
            return nil
        }
        return TodoItem(id: id,
                        text: text,
                        importance: importance,
                        deadline: deadline,
                        isDone: isDone,
                        createdOn: Date(timeIntervalSince1970: createdOn),
                        changedOn: changedOn)
    }
    
    var json: Any {
        let dictionary = ["id": self.id,
                          "text": self.text,
                          "importance": self.importance == .medium ? NSNull() : self.importance.rawValue,
                          "deadline":  self.deadline == nil ? NSNull() : self.deadline!.timeIntervalSince1970,
                          "isDone": self.isDone,
                          "createdOn": self.createdOn.timeIntervalSince1970,
                          "changedOn": self.changedOn == nil ? NSNull() : self.changedOn!.timeIntervalSince1970
        ] as [String : Any]
        return dictionary
    }
}
