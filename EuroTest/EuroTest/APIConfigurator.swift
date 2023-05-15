//
//  Configurator.swift
//  FDJ_Test
//
//  Created by Malek Mansour on 02/05/2023.
//


import Foundation
import UIKit

protocol APIConfiguratorContract: AnyObject {
    func fetchAllData(mocked: Bool, completion: @escaping completionHandler<APIResponse>) async throws
    var apiURL: String { get set }
}

enum Method: String {
    case get, post, put, delete
}
final class APIConfigurator: APIConfiguratorContract {
    
    lazy var apiURL: String = "https://extendsclass.com/api/json-storage/bin/"
    
    @available(*, renamed: "fetchAllData()")
    func fetchAllData(mocked: Bool, completion: @escaping completionHandler<APIResponse>) async throws {

        if mocked {
            return readLocalFile(forName: "mockedResponse", completionHandler: completion)
        }
        let function = "edfefba"
        guard let url = URL(string: apiURL+function) else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        let decodedPayload = try JSONDecoder().decode(APIResponse.self, from: data)
        completion(.success(decodedPayload))
    }
    
}
