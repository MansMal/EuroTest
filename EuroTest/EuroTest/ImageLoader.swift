//
//  ImageLoader.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import Foundation
import UIKit

actor ImageLoader {
    
    private enum LoaderStatus {
        case inProgress(Task<UIImage, Error>)
        case fetched(UIImage)
    }
    private var images: [URLRequest: LoaderStatus] = [:]

    public func fetch(_ url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        return try await fetch(request)
    }
    
    private func fetch(_ urlRequest: URLRequest) async throws -> UIImage {
        if let status = images[urlRequest] {
            switch status {
            case .fetched(let image):
                return image
            case .inProgress(let task):
                return try await task.value
            }
        }

        let task: Task<UIImage, Error> = Task {
            let (imageData, _) = try await URLSession.shared.data(for: urlRequest)
            let image = UIImage(data: imageData)!
            return image
        }

        images[urlRequest] = .inProgress(task)
        let image = try await task.value
        images[urlRequest] = .fetched(image)
        return image
    }
}
