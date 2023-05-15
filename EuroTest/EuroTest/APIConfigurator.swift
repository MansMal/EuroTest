//
//  Configurator.swift
//  FDJ_Test
//
//  Created by Malek Mansour on 02/05/2023.
//


import Foundation
import UIKit

enum Method: String {
    case get, post, put, delete
}
final class APIConfigurator: ObservableObject {
    
    lazy var apiURL: String = "https://extendsclass.com/api/json-storage/bin/"
    
    func fetchAllData() async throws -> APIResponse {
        let function = "edfefba"
        guard let url = URL(string: apiURL+function) else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
        let decodedPayload = try JSONDecoder().decode(APIResponse.self, from: data)
        return decodedPayload
    }
    
}
