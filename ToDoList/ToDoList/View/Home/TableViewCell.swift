//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Aliya on 27.06.2023.
//

import UIKit

final class TableViewCell: UITableViewCell {


//MARK: - Properties

    static let identifier = "TableViewCell"
    var taskTextLabel = makeTaskTextLabel()

    lazy var deadlineDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.labelTertiary
        label.font = Constants.font15
        label.numberOfLines = 1

        return label
    }()

    lazy var calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var propButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()


    private static func makeTaskTextLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.font = Constants.font17
        label.textColor = Colors.labelPrimary

        label.numberOfLines = 3
        return label
    }

    // MARK: - Initialization, override

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setConstraints()

    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setConstraints()
    }

//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//
//    }

    override func prepareForReuse() {
        super.prepareForReuse()
//        self.calendarImageView = UIImageView()
//        self.deadlineDateLabel = UILabel()
//        self.propButton = UIButton()
//        self.taskTextLabel = UILabel()
    }


    // MARK: - Set and Constraints Funcs

    private func setConstraints() {
        self.contentView.addSubview(propButton)
        self.contentView.addSubview(taskTextLabel)
        self.contentView.addSubview(calendarImageView)
        self.contentView.addSubview(deadlineDateLabel)


        NSLayoutConstraint.activate([

            propButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            propButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            propButton.widthAnchor.constraint(equalToConstant: 24),
            propButton.heightAnchor.constraint(equalToConstant: 24),

            taskTextLabel.leadingAnchor.constraint(equalTo: propButton.trailingAnchor, constant: 12),
            taskTextLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            taskTextLabel.bottomAnchor.constraint(equalTo: deadlineDateLabel.topAnchor),
            taskTextLabel.widthAnchor.constraint(equalToConstant: 252),

            calendarImageView.leadingAnchor.constraint(equalTo: propButton.trailingAnchor, constant: 12),
            calendarImageView.topAnchor.constraint(equalTo: deadlineDateLabel.topAnchor),
            calendarImageView.heightAnchor.constraint(equalTo: deadlineDateLabel.heightAnchor),
            calendarImageView.widthAnchor.constraint(equalTo: calendarImageView.heightAnchor),

            deadlineDateLabel.leadingAnchor.constraint(equalTo: calendarImageView.trailingAnchor, constant: 2),
            deadlineDateLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            deadlineDateLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 58),

        ])
    }

}
