//
//  MainScreenViewController.swift
//  ToDoList
//
//  Created by Aliya on 27.06.2023.
//

import UIKit

class MainScreenViewController: UIViewController {

//MARK: - Properties

    private let toDoTableView = ToDoTableView()
    private lazy var hiddenTasksView = HiddenTasksView(doneTasksNumber: 0)
    let tasks = TasksLaunching()

    private var items: [TodoItem]
//    private var items: [TodoItem] {
//        didSet {
//            print("changed")
//            DispatchQueue.global().sync {
//                tasks.updateCache(items: items)
//            }
//        }
//    }

    private lazy var newTaskButton: UIButton = {
        let button = UIButton()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Images.plus, for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .allEvents)

        return button
    }()

//MARK: -

    init() {
        items = tasks.cache.toDoItems.map {$0.value}
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setControllerParameters()
        setHiddenTasksBar()
        setTableView()
        setNewTaskButton()
    }

    @objc func plusButtonTapped(){
        let taskViewController = TaskViewController()
        let taskNavigationController = UINavigationController(rootViewController: taskViewController)
        taskViewController.delegate = self
        self.present(taskNavigationController, animated: true)
    }

    private func setNewTaskButton() {
        self.view.addSubview(newTaskButton)

        NSLayoutConstraint.activate([
            newTaskButton.widthAnchor.constraint(equalToConstant: 44),
            newTaskButton.heightAnchor.constraint(equalToConstant: 44 ),
            newTaskButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            newTaskButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func setControllerParameters() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Мои дела"
        self.view.backgroundColor = Colors.backPrimary

    }

    private func setHiddenTasksBar() {
        //        hiddenTasksView = HiddenTasksView(doneTasksNumber: tasks.numberOfDoneTasks())
        hiddenTasksView = HiddenTasksView(doneTasksNumber: items.filter{$0.isDone == true}.count)
        
        view.addSubview(hiddenTasksView)

        NSLayoutConstraint.activate([
            hiddenTasksView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hiddenTasksView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hiddenTasksView.widthAnchor.constraint(equalTo:self.view.widthAnchor),
            hiddenTasksView.heightAnchor.constraint(equalToConstant: 20)
        ])

    }


    private func setTableView () {
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        toDoTableView.backgroundColor = Colors.backPrimary

        view.addSubview(toDoTableView)

        NSLayoutConstraint.activate([
            toDoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            toDoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            toDoTableView.topAnchor.constraint(equalTo: hiddenTasksView.bottomAnchor, constant: 12),
            toDoTableView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor),

        ])


        toDoTableView.layer.cornerRadius = 16
    }
}

//MARK: - Table Delegates
extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = toDoTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell else {
            return UITableViewCell()
        }

        if indexPath.item != items.count {
//            let currentTask = items[items.index(items.startIndex, offsetBy: indexPath.item)].value
            let currentTask = items[indexPath.item]
            let propImage = choosePropImage(item: currentTask)

            cell.accessoryType = .disclosureIndicator

            cell.propButton.setImage(propImage, for: .normal)
            cell.propButton.addTarget(self, action: #selector(pushPropButton), for: .touchDown)
//            cell.taskTextLabel.text = currentTask.importance == .high ? "‼️" + currentTask.text : currentTask.text
            cell.taskTextLabel.text = currentTask.text
            if let deadline = currentTask.deadline {
                cell.deadlineDateLabel.text = createDeadlineString(date: deadline)
                cell.calendarImageView.image = Images.calendar
            }
        } else {
            cell.taskTextLabel.text = "Новое"
            cell.taskTextLabel.textColor = Colors.labelTertiary
            cell.propButton.setImage(UIImage(), for: .normal)
        }

//        if indexPath.row == items.count {
//            cell.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//            cell.layer.cornerRadius = 16
//        }
        return cell
    }

    @objc private func pushPropButton(index: Int) {

//        if items[index].isDone == true {
//            items[index].isDone = false
//        } else {
//            items[index].isDone = true
//        }
//        toDoTableView.reloadData()
    }

    private func createDeadlineString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC+3")! as TimeZone
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

    private func choosePropImage(item: TodoItem) -> UIImage {
        var result: UIImage?
        if item.isDone {
            result = Images.propOn
        }
        else {
            if item.importance == .high {
                result = Images.propHightPriority
            } else {
                result = Images.propOff
            }
        }

        if let image = result {
            return image
        } else {
            return UIImage()
        }
    }


//MARK: - Row Actions

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.row < items.count else {
            return UISwipeActionsConfiguration()
        }
        let completeAction = UIContextualAction(style: .destructive, title: nil, handler: {_,_,_ in
            if self.items[indexPath.item].isDone == false {
                self.items[indexPath.item].isDone = true
            } else {
                self.items[indexPath.item].isDone = false
            }
            self.toDoTableView.reloadData()
            self.tasks.updateCache(item: self.items[indexPath.item], action: .update)
        })
        completeAction.backgroundColor = Colors.colorGreen
        completeAction.image = Images.complete

        return UISwipeActionsConfiguration(actions: [completeAction])
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.row < items.count else {
            return UISwipeActionsConfiguration()
        }
        let deleteAction = UIContextualAction(style: .normal, title: nil, handler: { _,_,_ in
            self.tasks.updateCache(item: self.items[indexPath.row], action: .delete)
            self.items.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        deleteAction.backgroundColor = Colors.colorRed
        deleteAction.image = Images.delete

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var taskViewController: TaskViewController
        if indexPath.row < items.count {
            taskViewController = TaskViewController(item: items[indexPath.row])
        } else {
            taskViewController = TaskViewController()
        }
        let taskNavigationController = UINavigationController(rootViewController: taskViewController)
        taskViewController.delegate = self
        self.present(taskNavigationController, animated: true)

    }
}


extension MainScreenViewController: TaskViewDelegate {
    func updateTasks(updatedItem: TodoItem) {
        dismiss(animated: true, completion: {
            defer {
                self.toDoTableView.reloadData()
                self.toDoTableView.layoutIfNeeded()
                self.tasks.updateCache(item: updatedItem, action: .update)
            }
            var i = 0
            while i < self.items.count {
                if self.items[i].id == updatedItem.id {
                    self.items[i] = updatedItem
                    return
                }
                i += 1
            }
            self.items.append(updatedItem)
        })
    }


}



