//
//  RequestType.swift
//  ToDoList
//
//  Created by Aliya on 07.07.2023.
//

import Foundation

enum RequestType: String {
    case getList
    case getById
    case deleteById = "DELETE"
    case patch = "PATCH"
    case post = "POST"
}
