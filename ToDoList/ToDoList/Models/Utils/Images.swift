//
//  Images.swift
//  ToDoList
//
//  Created by Aliya on 29.06.2023.
//

import Foundation
import UIKit
import SwiftUI

enum Images {
    static let propOff = UIImage(named: "Prop=off")
    static let propOn = UIImage(named: "Prop=on")
    static let propHightPriority = UIImage(named: "Prop=High Priority")

    static let calendar = UIImage(named: "Calendar")

    static let highPriority = UIImage(named: "high")
    static let lowPriority = UIImage(named: "low")

    static let plus = UIImage(named: "Plus")

    static let delete = UIImage(named: "delete")
    static let complete = UIImage(named: "complete")

    static func choosePropImage(item: TodoItem) -> UIImage {
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

    static func getImage(image: UIImage?) -> Image {
        if let imageToReturn = image {
            return Image(uiImage: imageToReturn)
        } else {
            return Image(systemName: "heart.fill")
        }
    }

}
