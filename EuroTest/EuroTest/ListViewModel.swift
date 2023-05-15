//
//  ListViewModel.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import Foundation

protocol DataSourceContract: AnyObject {
    var service: APIConfiguratorContract { get set }
    var collectionData: [CollectionItem]! { get set }
    var dataList: APIResponse! { get set }
    func bindData(mocked: Bool)
}
final class ListViewModel: NSObject, DataSourceContract {
  
    var service: APIConfiguratorContract = APIConfigurator()
    var dataList: APIResponse!
    var collectionData: [CollectionItem]!
    
    convenience init(for mocked: Bool) {
        self.init()
        self.bindData(mocked: mocked)
    }
    
    override init() {
        super.init()
        self.bindData(mocked: false)
    }
    
    func bindData(mocked: Bool) {
        Task.init(priority: .medium, operation: {
            do {
                try await service.fetchAllData(mocked: mocked, completion: { result in
                    switch result {
                    case .success(let payload):
                        self.collectionData = self.mapResponseToCollectionData(with: payload)
                    case .failure(let error):
                        dump(error)
                    }
                })
            } catch {
                print(error)
            }
        })
    }
    
    func mapResponseToCollectionData(with data: APIResponse) -> [CollectionItem] {
        let videos = data.videos.map { vid -> CollectionItem in
            let data = CollectionItem(type: .video, imageURL: vid.thumb,
                                          subTitle: vid.sport.name, title: vid.title,
                                          desc: "\(vid.views) views", date: vid.date)
            return data
        }
        let stories = data.stories.map { stor -> CollectionItem in
            let story = CollectionItem(type: .story, imageURL: stor.image,
                                           subTitle: stor.sport.name, title: stor.title,
                                           desc: "By \(stor.author) at \(stor.date.toDataString())", date: stor.date)
            return story
        }
        let result = self.merge(videos, stories).sorted { $0.date > $1.date }
        return result
    }
    
    func merge<T>(_ arrays: [T]...) -> [T] {
        guard let longest = arrays.max(by: { $0.count < $1.count })?.count else { return [] }
        var result = [T]()
        for index in 0..<longest {
            for array in arrays {
                guard index < array.count else { continue }
                result.append(array[index])
            }
        }
        return result
    }
}
