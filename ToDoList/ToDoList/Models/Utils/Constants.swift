//
//  Constants.swift
//  ToDoList
//
//  Created by Aliya on 27.06.2023.
//

import Foundation
import UIKit
import SwiftUI

enum Constants {
    static let leadingConstraint = 16.0
    static let trailingConstraint = -16.0
    static let cornerRadius = 16.0
    static let font17 = UIFont(name: "GeezaPro", size: 17)
    static let font15 = UIFont(name: "GeezaPro", size: 15)

    static func setFont(font: UIFont?) -> Font {
        if let font = font {
            return Font(font)
        }
        else {
            return Font(.init(.label, size: 15))
        }
    }
}
