//
//  ToDoTableView.swift
//  ToDoList
//
//  Created by Aliya on 27.06.2023.
//

import UIKit


class ToDoTableView: UITableView {
    init() {
        super.init(frame: .zero, style: .plain)

        self.translatesAutoresizingMaskIntoConstraints = false

        self.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        self.backgroundColor = Colors.backSecondary

        self.rowHeight = ToDoTableView.automaticDimension
        self.estimatedRowHeight = 100
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
