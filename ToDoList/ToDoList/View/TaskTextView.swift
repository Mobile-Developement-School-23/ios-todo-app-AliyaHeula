//
//  TaskTextView.swift
//  ToDoList
//
//  Created by Aliya on 23.06.2023.
//

import UIKit

final class TaskTextView: UITextView {

    func setTaskTextView() -> UITextView {
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.cornerRadius = 16
//        self.text = "Что надо сделать?"
        self.text = TasksLaunching.cache.toDoItems.first?.value.text ?? "Что надо сделать?"

        self.contentInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        self.font = UIFont.systemFont(ofSize: 17)
        self.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        return self
    }

}
