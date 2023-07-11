//
//  NetworkRequest.swift
//  ToDoList
//
//  Created by Aliya on 07.07.2023.
//

import Foundation
import UIKit

final class NetworkRequest {
//    var items = [NetworkTodoItem]()
    var items: [NetworkTodoItem]?
    var isDirty = false

    let url: URL
    var revision = Int32(5)
    var urlRequest: URLRequest
    
    let session = URLSession.shared

    init(url: URL) {
        self.url = url
        self.urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = ["Authorization" : "Bearer desiccators"]
    }

    func captureRevision() async {
        let handler = DefaultNetworkingService(session: session, urlRequest: urlRequest)
        if let revision = try? await handler.handleRequest()?.revision {
            self.revision = revision
        }
    }

    func runRequest(requestType: RequestType, id: String?) async {
        switch requestType {
        case .getList: 
            urlRequest.httpMethod = "GET"
        case .getById:
            urlRequest.httpMethod = "GET"
            guard let id = id else {
                return
            }
            let newUrl = url.appending(component: id)
            self.urlRequest = URLRequest(url: newUrl)
            self.urlRequest.allHTTPHeaderFields = ["Authorization" : "Bearer desiccators",
                                              "X-Last-Known-Revision" : "\(self.revision)"]
        case .deleteById:
            guard let id = id else {
                return
            }
            let newUrl = url.appending(component: id)
            self.urlRequest = URLRequest(url: newUrl)
            self.urlRequest.httpMethod = requestType.rawValue
            self.urlRequest.allHTTPHeaderFields = ["Authorization" : "Bearer desiccators",
                                              "X-Last-Known-Revision" : "\(self.revision)"]
        case .patch:
            self.urlRequest.httpMethod = requestType.rawValue
            self.urlRequest.allHTTPHeaderFields?.updateValue("\(self.revision)", forKey: "X-Last-Known-Revision")
            let itemsToPatch = TasksLaunching().cache.toDoItems.map{ $0.value }
            let data = HTTPRequestBody(items: itemsToPatch)
//            var list = [NetworkTodoItem]()
//            for item in itemsToPatch {
//                list.append(NetworkTodoItem(item: item))
//            }
//            var data = [String: Any]()
//            data["status"] = "ok"
//            data["list"] = list

//            guard JSONSerialization.isValidJSONObject(data) else {
//                print("JSON object creation error. Data is not saved.")
//                return
//            }
            
//            guard let requestBody = try? JSONSerialization.data(withJSONObject: data) else {
//                return
//            }
            guard let requestBody = try? JSONEncoder().encode(data) else {
                return
            }
            urlRequest.httpBody = requestBody

        case .post:
            self.urlRequest.httpMethod = requestType.rawValue
            self.urlRequest.allHTTPHeaderFields?.updateValue("\(self.revision)", forKey: "X-Last-Known-Revision")
            self.urlRequest.allHTTPHeaderFields?.updateValue("application/json", forKey: "Content-Type")
            self.urlRequest.allHTTPHeaderFields?.updateValue("keep-alive", forKey: "Connection")
            let itemToPost = NetworkTodoItem(item: TodoItem(id: "777", text: "ddd", importance: .high, deadline: .now + 5, isDone: false, createdOn: .now, changedOn: .now))
            let data = Test(element: itemToPost)


            guard let requestBody = try? JSONEncoder().encode(data) else {
                return
            }
            urlRequest.httpBody = requestBody
            

        }
        
        let handler = DefaultNetworkingService(session: session, urlRequest: urlRequest)
        do {
            let responseBody = try await handler.handleRequest()
            if let revision = responseBody?.revision {
                self.revision = revision
            }
            if let list = responseBody?.list {
                self.items = list
            } else if let element = responseBody?.element {
                self.items = [NetworkTodoItem]()
                self.items?.append(element)
            }
        } catch {
            print("Error: \(error)")
        }
    }

}
