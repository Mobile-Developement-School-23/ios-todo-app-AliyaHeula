//
//  DefaultNetworkingService.swift
//  ToDoList
//
//  Created by Aliya on 05.07.2023.
//

import Foundation
import UIKit

enum ConnectionErrors: Error{
    case unreachableUrl
    case serverError
    case incorrectData
}


protocol NetworkingService {
    func handleRequest(completion: @escaping ((Data?, HTTPURLResponse?, Error?) throws -> Void))
}

final class DefaultNetworkingService: NetworkingService {

    let session: URLSession
    var urlRequest: URLRequest

    init(session: URLSession, urlRequest: URLRequest) {
        self.session = session
        self.urlRequest = urlRequest
    }

    func handleRequest(completion: @escaping ((Data?, HTTPURLResponse?, Error?) throws -> Void)) {
        self.session.dataTask(with: self.urlRequest) {
            (data, response, error) in
            if let response = response as? HTTPURLResponse {
                do {
                    try completion(data, response, error)
                } catch {
                    print("Error: \(error)")
                    return
                }

            }
        }.resume()
    }

    func handleRequest() async throws-> HTTPBody? {
        await withCheckedContinuation { continuation in
            handleRequest { (data, response, error) in
                
                if let error = error {
                    continuation.resume(returning: nil)
                    throw error
                }
                if let response = response,
                   !(200..<300).contains(response.statusCode) {
                    print("Status code is ", response.statusCode)
                    continuation.resume(returning: nil)
                    throw ConnectionErrors.serverError
                }
                guard let data = data else {
                    continuation.resume(returning: nil)
                    throw ConnectionErrors.incorrectData
                }
                do {
                    let responseBody = try JSONDecoder().decode(HTTPBody.self, from: data)
                        continuation.resume(returning: responseBody)

                } catch {

                    throw error
                }

            }
        }
    }

}
