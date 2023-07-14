//
//  TaskViewController.swift
//  ToDoList
//
//  Created by Aliya on 21.06.2023.
//

import UIKit
import spm

protocol TaskViewDelegate {
    func updateTasks(updatedItem: TodoItem)
}

final class TaskViewController: UIViewController {

//MARK: - Properies

    private let taskTextView = TaskTextView()
    private let stackView: TaskStackView
    private let deleteButton = DeleteButton()
    private var item: TodoItem
    private var taskText: String?

    var delegate: TaskViewDelegate?

//MARK: -
    init() {
        self.item = TodoItem(id: nil, text: "", importance: .medium, deadline: nil, isDone: false, createdOn: Date(), changedOn: nil)
        self.stackView = TaskStackView(importance: nil, deadline: nil)
        super.init(nibName: nil, bundle: nil)
    }


    init(item: TodoItem) {
        self.item = item
        self.stackView = TaskStackView(importance: item.importance, deadline: item.deadline)
        super.init(nibName: nil, bundle: nil)
        taskText = item.text

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

//        becomeFirstResponder()

        setNavigationBar()
        taskTextView.setTaskTextView()
        taskTextView.text = self.taskText ?? "Что надо сделать?"
        view.addSubview(taskTextView)
        setTaskTextViewConstraints()
        view.addSubview(stackView.setStackView())
        
        setStackConstraints()
        view.addSubview(deleteButton.setDeleteButton())
        setDeleteButtonConstraints()


        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        self.stackView.calendarView.selectionBehavior = dateSelection
    }

    private func setDeleteButtonConstraints() {
        deleteButton.button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.button.topAnchor.constraint(equalTo: stackView.stack.bottomAnchor, constant: 16),
            deleteButton.button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            deleteButton.button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            deleteButton.button.heightAnchor.constraint(equalToConstant: 56),

        ])
        deleteButton.button.layer.cornerRadius = 16
    }

    private func setStackConstraints() {

        stackView.stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.stack.topAnchor.constraint(equalTo: taskTextView.bottomAnchor, constant: 16),
            stackView.stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        stackView.stack.layer.cornerRadius = 16
    }

    private func setNavigationBar() {
        view.backgroundColor = Colors.backPrimary
        self.title = "Дело"

        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
//        navigationItem.rightBarButtonItem?.isEnabled = false

    }

    private func setTaskTextViewConstraints() {
        taskTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taskTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            taskTextView.heightAnchor.constraint(equalToConstant: 120),
            taskTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            taskTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            taskTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 56)
//            text.topAnchor.constraint(equalTo: navigationController!.navigationBar.bottomAnchor)
            ])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.taskTextView.resignFirstResponder()
    }

    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }

    @objc func saveButtonTapped() {

        self.item.text = self.taskTextView.text
        self.item.importance = self.stackView.importance
        self.item.deadline = self.stackView.deadline
        self.item.changedOn = Date()
        self.delegate?.updateTasks(updatedItem: item)
        print(item)
        
    }

    override func viewWillAppear(_ animated: Bool) {

    }
}

extension TaskViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        self.stackView.deadline = dateComponents?.date
        self.view.layoutIfNeeded()
        
    }
}

