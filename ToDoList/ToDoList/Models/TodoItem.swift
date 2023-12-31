import Foundation
import spm


struct TodoItem {
    let id: String
    var text: String
    var importance: Importance
    var deadline: Date?
    var isDone: Bool
    let createdOn: Date
    var changedOn: Date?
    
    init(id: String?, text: String, importance: Importance, deadline: Date?, isDone: Bool, createdOn: Date, changedOn: Date?) {
        self.id = id ?? UUID().uuidString
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
              let createdOn = dictionary["createdOn"] as? TimeInterval
        else {
            return nil
        }
        
        //Check importance, deadline and changedOn parameters for nil:
        var importance = Importance.medium
        if let str = dictionary["importance"] as? String,
           let tmp = Importance(rawValue: str) {
            importance = tmp
        }
        
        var deadline: Date? = nil
        if let tmp = dictionary["deadline"] as? TimeInterval {
            deadline = Date(timeIntervalSince1970: tmp)
        }

        var changedOn: Date? = nil
        if let tmp = dictionary["changedOn"] as? TimeInterval {
            changedOn = Date(timeIntervalSince1970: tmp)
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
        var dictionary:[String: Any] = [:]
        dictionary["id"] = self.id
        dictionary["text"] = self.text
        if self.importance != .medium {
            dictionary["importance"] = self.importance.rawValue
        }
        if let deadline = self.deadline {
            dictionary["deadline"] = deadline.timeIntervalSince1970
        }
        dictionary["isDone"] = self.isDone
        dictionary["createdOn"] = self.createdOn.timeIntervalSince1970
        if let changedOn = self.changedOn {
            dictionary["changedOn"] = changedOn.timeIntervalSince1970
        }
        return dictionary
    }

    var sqlReplaceStatement: String {
        var deadline: String
        if let check = self.deadline {
            deadline = "\"\(check.dateTimeString)\""
        } else {
            deadline = "NULL"
        }
        var chanedOn: String
        if let check = self.changedOn {
            chanedOn = "\"\(check.dateTimeString)\""
        } else {
            chanedOn = "NULL"
        }
        let isDone: Int = self.isDone == false ? 0 : 1

        let returnValue = "(\"\(self.id)\", \"\(self.text)\", \"\(self.importance.rawValue)\", \(deadline), \(isDone), \"\(self.createdOn.dateTimeString)\", \(chanedOn))"
        return returnValue
    }
}


