//
//  TaskStackView.swift
//  ToDoList
//
//  Created by Aliya on 23.06.2023.
//

import UIKit
import spm

final class TaskStackView {

    var importance: Importance
    var importanceSegmControl = UISegmentedControl()
    let importanceRow = UIView()

    var deadline: Date?
    let deadlineSwitch = UISwitch()
    let calendar: UICalendarView = {
        let gregorianCalendar = Calendar(identifier: .gregorian)
        let calendar = UICalendarView()
        calendar.calendar = gregorianCalendar
        calendar.locale = Locale(identifier: "ru")
        calendar.fontDesign = .default
        return calendar
    }()
//   @objc let deadlineDate = UIButton(type: .roundedRect)
    let deadlineRow = UIView()
    var isCalendarOpen = false


    lazy var stack: UIStackView = {
        let newStack = UIStackView()
        newStack.axis = .vertical
        newStack.alignment = .fill
        newStack.distribution = .equalSpacing
        newStack.spacing = 0
        newStack.backgroundColor = Colors.backSecondary
        return newStack
    }()

    init(importance: Importance?, deadline: Date?) {
        self.importance = importance ?? Importance.medium
        self.deadline = deadline

    }

//MARK: - Stack View

    func setStackView() -> UIStackView {
        
        createImportanceRow()
        createDeadlineRow()
        stack.addArrangedSubview(importanceRow)
        stack.addArrangedSubview(createSeparator())
        stack.addArrangedSubview(deadlineRow)

        return stack

    }

    func createSeparator() -> UIView{
        let separator = UIView()
        let line = UIView()
        line.backgroundColor = Colors.supportSeparator

        separator.translatesAutoresizingMaskIntoConstraints = false
        line.translatesAutoresizingMaskIntoConstraints = false

        separator.addSubview(line)
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 1.0 / UIScreen.main.scale),
            line.heightAnchor.constraint(equalTo:separator.heightAnchor),
            line.leadingAnchor.constraint(equalTo: separator.leadingAnchor, constant: 16),
            line.trailingAnchor.constraint(equalTo: separator.trailingAnchor, constant: -16)

        ])
        return separator
    }

//MARK: - Deadline part

    func createDeadlineRow() {
        let deadlineLabel = UILabel()
        deadlineLabel.text = "Сделать до"
        deadlineLabel.font = UIFont(name: "GeezaPro", size: 17)

        let deadlineDate = UIButton()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMMM yyyy"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone


        if self.deadline != nil {
            deadlineDate.setTitle(dateFormatter.string(from: self.deadline!),
                                  for: .normal)
            deadlineDate.setTitleColor(UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1),
                                       for: .normal)
            deadlineDate.titleLabel?.font = UIFont(name: "GeezaPro", size: 13)
            deadlineDate.addTarget(self, action: #selector(openCalendar), for: .allEvents)

        }

        deadlineRow.addSubview(deadlineLabel)
        deadlineRow.addSubview(deadlineSwitch)

        deadlineRow.translatesAutoresizingMaskIntoConstraints = false
        deadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        deadlineSwitch.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            deadlineSwitch.topAnchor.constraint(equalTo: deadlineRow.topAnchor, constant: 12.5),
            deadlineSwitch.trailingAnchor.constraint(equalTo: deadlineRow.trailingAnchor, constant: -12),
            deadlineSwitch.bottomAnchor.constraint(equalTo: deadlineRow.bottomAnchor, constant: -12.5),

//            deadlineLabel.heightAnchor.constraint(equalToConstant: 22),
//            deadlineLabel.bottomAnchor.constraint(equalTo: deadlineDate.bottomAnchor),
//            deadlineLabel.leadingAnchor.constraint(equalTo: deadlineRow.leadingAnchor, constant: 16),
//
//
//            deadlineLabel.topAnchor.constraint(equalTo: deadlineRow.topAnchor, constant: 17),


//            deadlineDate.heightAnchor.constraint(equalToConstant: 18),
//            deadlineDate.bottomAnchor.constraint(equalTo: deadlineRow.bottomAnchor, constant: -8),
//            deadlineDate.leadingAnchor.constraint(equalTo: deadlineRow.leadingAnchor, constant: 16)
        ])

        deadlineSwitch.isOn = self.deadline == nil ? false : true
        deadlineSwitch.addTarget(self, action: #selector(tapDeadlineSwitcher), for: .valueChanged)

        if self.deadline == nil {
            NSLayoutConstraint.activate([
                deadlineLabel.topAnchor.constraint(equalTo: deadlineRow.topAnchor, constant: 17),
                deadlineLabel.bottomAnchor.constraint(equalTo: deadlineRow.bottomAnchor, constant: -17),
                deadlineLabel.leadingAnchor.constraint(equalTo: deadlineRow.leadingAnchor, constant: 16),
            ])
        } else {
            deadlineRow.addSubview(deadlineDate)

            deadlineDate.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                deadlineLabel.topAnchor.constraint(equalTo: deadlineRow.topAnchor, constant: 8),
                deadlineLabel.heightAnchor.constraint(equalToConstant: 22),
                deadlineLabel.leadingAnchor.constraint(equalTo: deadlineRow.leadingAnchor, constant: 16),
//                deadlineLabel.bottomAnchor.constraint(equalTo: deadlineRow.bottomAnchor, constant: -17),
//                deadlineDate.topAnchor.constraint(equalTo: deadlineLabel.topAnchor),
                deadlineDate.heightAnchor.constraint(equalToConstant: 18),
                deadlineDate.bottomAnchor.constraint(equalTo: deadlineRow.bottomAnchor, constant: -8),
                deadlineDate.leadingAnchor.constraint(equalTo: deadlineRow.leadingAnchor, constant: 16)

            ])

        }


    }

    @objc func tapDeadlineSwitcher(sender: UISwitch) {
        
        if sender.isOn {
//            if self.deadline == nil {
                self.deadline = Date(timeInterval: 86400, since: Date())
//                self.isDeadlineExist = true
//            }
        } else {
            self.deadline = nil
//            self.isDeadlineExist = false
        }
    }

    let calendarView = UIView()

     @objc func openCalendar(sender: UIButton) {
         if isCalendarOpen == false {
             isCalendarOpen = true

             calendarView.addSubview(calendar)

             stack.addArrangedSubview(createSeparator())
             stack.addArrangedSubview(calendarView)

             calendar.translatesAutoresizingMaskIntoConstraints = false
             calendarView.translatesAutoresizingMaskIntoConstraints = false
             NSLayoutConstraint.activate([
                calendarView.heightAnchor.constraint(equalTo: calendar.heightAnchor),
                calendar.topAnchor.constraint(equalTo: calendarView.topAnchor),
                calendar.leftAnchor.constraint(equalTo: calendarView.leftAnchor, constant: 16),
                calendar.rightAnchor.constraint(equalTo: calendarView.rightAnchor, constant: -16)
             ])
         } else {
//             isCalendarOpen = false
//             stack.removeArrangedSubview(calendarView)
         }
    }

//MARK: - Importance part

    func createImportanceRow() {
        let importanceLabel = UILabel()
        importanceLabel.text = "Важность"
        var segmentsArray = [Any]()

        if let lowSegmentImage = UIImage(named: "low") {
            segmentsArray.append(lowSegmentImage.withRenderingMode(.alwaysOriginal))
        }
        segmentsArray.append("нет")
        if let highSegmentImage = UIImage(named: "high") {
            segmentsArray.append(highSegmentImage.withRenderingMode(.alwaysOriginal))
        }

        let importanceSegmControl = UISegmentedControl(items: segmentsArray)
        importanceSegmControl.selectedSegmentIndex = Importance.allCases.firstIndex(of: self.importance) ?? 1
        importanceSegmControl.addTarget(self, action: #selector(changeImportance), for: .valueChanged)

        importanceSegmControl.layer.cornerRadius = 9

        importanceRow.addSubview(importanceLabel)
        importanceRow.addSubview(importanceSegmControl)

        importanceLabel.font = UIFont(name: "GeezaPro", size: 17)
        importanceRow.translatesAutoresizingMaskIntoConstraints = false
        importanceLabel.translatesAutoresizingMaskIntoConstraints = false
        importanceSegmControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            importanceRow.heightAnchor.constraint(equalToConstant: 56),
            importanceLabel.topAnchor.constraint(equalTo: importanceRow.topAnchor, constant: 17),
            importanceLabel.leadingAnchor.constraint(equalTo: importanceRow.leadingAnchor, constant: 16),
            //            importanceLabel.trailingAnchor.constraint(equalTo: importanceSegmControl.leadingAnchor, constant: 16),
            importanceLabel.bottomAnchor.constraint(equalTo: importanceRow.bottomAnchor, constant: -17),
            importanceSegmControl.topAnchor.constraint(equalTo: importanceRow.topAnchor, constant: 10),
            importanceSegmControl.trailingAnchor.constraint(equalTo: importanceRow.trailingAnchor, constant: -12),
            importanceSegmControl.bottomAnchor.constraint(equalTo: importanceRow.bottomAnchor, constant: -10),
            importanceSegmControl.heightAnchor.constraint(equalToConstant: 36),
            importanceSegmControl.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

    @objc func changeImportance(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.importance = .low
        case 2:
            self.importance = .high
        default:
            self.importance = .medium
        }
    }


}


