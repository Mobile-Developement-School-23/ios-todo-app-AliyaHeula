//
//  testNetwork.swift
//  ToDoList
//
//  Created by Aliya on 06.07.2023.
//

import Foundation
import UIKit


func testNetwork() throws {
    guard let url = URL(string: "https://beta.mrdekk.ru/todobackend/list"),
            UIApplication.shared.canOpenURL(url) else {
        throw ConnectionErrors.unreachableUrl
    }

    let networkRequest = NetworkRequest(url: url)
    Task {
        await networkRequest.captureRevision()
        await networkRequest.runRequest(requestType: .getList, id: nil)
        print("""
          test GET list:
          revision: \(networkRequest.revision)
          items: \(String(describing: networkRequest.items))


          """)
        networkRequest.items = nil
        await networkRequest.runRequest(requestType: .getById, id: "1")
        print("""
          test GET by id:
          revision: \(networkRequest.revision)
          items: \(String(describing: networkRequest.items))


          """)

        networkRequest.items = nil
        await networkRequest.runRequest(requestType: .deleteById, id: "1")
        print("""
          test DELETE by id:
          revision: \(networkRequest.revision)
          items: \(String(describing: networkRequest.items))


          """)

    }




}
