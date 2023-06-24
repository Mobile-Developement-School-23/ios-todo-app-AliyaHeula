//
//  TaskViewController.swift
//  ToDoList
//
//  Created by Aliya on 21.06.2023.
//

import UIKit

final class TaskViewController: UIViewController {

    let taskTextView = TaskTextView()
    let stackView = TaskStackView()
    let deleteButton = DeleteButton()
    
    override var navigationController: UINavigationController? {
        UINavigationController()
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setNavigationBar()
//        taskTextView.setTaskTextView()
        view.addSubview(taskTextView.setTaskTextView())
        setTaskTextViewConstraints()
        view.addSubview(stackView.setStackView())
        setStackConstraints()
//        view.addSubview(deleteButton.setDeleteButton())
        view.addSubview(deleteButton.setDeleteButton())
        setDeleteButtonConstraints()

    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if !stackView.deadlineSwitch.isOn {
//            view.layoutIfNeeded()
//        }
//    }
    private func setDeleteButtonConstraints() {
//        deleteButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            deleteButton.topAnchor.constraint(equalTo: stackView.stack.bottomAnchor, constant: 16),
//            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            deleteButton.heightAnchor.constraint(equalToConstant: 56),
//
//        ])
//        deleteButton.layer.cornerRadius = 16

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
        view.backgroundColor = UIColor(red: 247 / 255, green: 246 / 255, blue: 242 / 255, alpha: 1)
        title = "Дело"
        let cancelButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = cancelButton
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButtonButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.rightBarButtonItem?.isEnabled = false
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

    @objc func cancelButtonButtonTapped() {
    }

    @objc func saveButtonButtonTapped() {
    }

    override func viewWillAppear(_ animated: Bool) {

    }

}



