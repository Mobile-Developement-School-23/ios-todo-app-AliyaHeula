//
//  DeleteButton.swift
//  ToDoList
//
//  Created by Aliya on 24.06.2023.
//

import UIKit

//class DeleteButton: UIButton {
class DeleteButton {

    let button = UIButton(type: .roundedRect)
    func setDeleteButton() -> UIButton {

        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)

        button.setTitle("Удалить", for: .normal)
        button.setTitle("Удалить", for: .disabled)
        button.titleLabel?.font = UIFont(name: "GeezaPro", size: 17)
        button.setTitleColor(UIColor(red: 1, green: 59 / 255, blue: 48 / 255, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.3), for: .disabled)
//        button.isEnabled = false
        return button
    }

}
