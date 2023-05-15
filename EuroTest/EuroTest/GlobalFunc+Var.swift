//
//  GlobalFunc+Var.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import Foundation

// swiftlint:disable type_name

typealias result<T> = Result<T, EuroError>
typealias completionHandler<T> = (result<T>) -> Void

enum GlobalConstants {
}

enum EuroError: String, Error {
    case none
    case unauthorized
    case businessError
    case unknownError
}
func readLocalFile<D: Decodable>(forName name: String,
                                 completionHandler: @escaping completionHandler<D>) {
    do {
        if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            do {
                let jsonDecoder = JSONDecoder()
                let item = try jsonDecoder.decode(D.self, from: jsonData)
                return completionHandler(.success(item))
            } catch let error {
                print("dataTask JSONDecoder error: \(error)")
                return
            }
        }
    } catch {
        print("readLocalFile Error: \(error)")
        return
    }
}
