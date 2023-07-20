//
//  Colors.swift
//  ToDoList
//
//  Created by Aliya on 29.06.2023.
//

import Foundation
import UIKit
import SwiftUI

enum Colors {
    static let backPrimary = UIColor(named: "BackPrimary")
    static let backSecondary = UIColor(named: "BackSecondary")


    static let labelTertiary = UIColor(named: "LabelTertiary")
    static let labelPrimary = UIColor(named: "LabelPrimary")

    static let colorRed = UIColor(named: "ColorRed")
    static let colorGreen = UIColor(named: "ColorGreen")
    static let colorBlue = UIColor(named: "ColorBlue")
    
    static let supportSeparator = UIColor(named: "SupportSeparator")

    static func captureUIColor(color: UIColor?) -> UIColor {
        if let colorToReturn = color {
            return colorToReturn
        } else {
            return .black
        }
    }

    static func captureColor(color: UIColor?) -> Color {
        if let colorToReturn = color {
            return Color(colorToReturn)
        } else {
            return Color.black
        }
    }
}
