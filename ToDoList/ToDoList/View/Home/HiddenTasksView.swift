//
//  HiddenTasksView.swift
//  ToDoList
//
//  Created by Aliya on 27.06.2023.
//

import UIKit

final class HiddenTasksView: UIView {

    let label = UILabel()
//    let doneTasksNumber = TasksLaunching.cache.numberOfDoneTasks()
    let doneTasksNumber: Int
    let showButton = UIButton(type: .roundedRect)

//    init() {
//        super.init(frame: .zero)
//    }

    init(doneTasksNumber: Int) {
        self.doneTasksNumber = doneTasksNumber
        super.init(frame: .zero)
        
        self.backgroundColor = Colors.backPrimary
        self.translatesAutoresizingMaskIntoConstraints = false
        setLabel()
        addSubview(label)
        setShowButton()
        addSubview(showButton)
        setConstraints()
    }

    private func setLabel() {
        self.label.text = "Выполнено — \(doneTasksNumber)"
        self.label.textColor = Colors.labelTertiary
        self.label.font = Constants.font15
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setShowButton() {
        self.showButton.setTitle("Показать", for: .normal)
        self.showButton.setTitleColor(Colors.colorBlue, for: .normal)
        self.showButton.titleLabel?.font = Constants.font15
        self.showButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            label.heightAnchor.constraint(equalTo: self.heightAnchor),

//            label.widthAnchor.constraint(equalToConstant: 147.5),
//            label.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: 195.5),

            showButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 32),
//            showButton.leadingAnchor.constraint(lessThanOrEqualTo: self.leadingAnchor, constant: 195.5),
//            showButton.leadingAnchor.constraint(lessThanOrEqualTo: label.trailingAnchor, constant: 0),
            showButton.heightAnchor.constraint(equalTo: self.heightAnchor),
//            showButton.widthAnchor.constraint(equalToConstant: 147.5),

            label.widthAnchor.constraint(equalTo: showButton.widthAnchor),
            label.trailingAnchor.constraint(equalTo: showButton.leadingAnchor, constant: 16),

        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

