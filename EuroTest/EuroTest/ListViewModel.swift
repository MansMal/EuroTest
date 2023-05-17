//
//  ListViewModel.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import Foundation

protocol DataSourceContract: AnyObject {
    var service: APIConfiguratorContract { get set }
    var collectionData: [CollectionItem]? { get set }
    var dataList: APIResponse? { get set }
    func bindData(mocked: Bool)
}
final class ListViewModel: NSObject, DataSourceContract {
  
    var service: APIConfiguratorContract = APIConfigurator()
    var dataList: APIResponse?
    var collectionData: [CollectionItem]?
    
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
                        self.dataList = payload
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
            let data = CollectionItem(id: vid.id, type: .video, imageURL: vid.thumb, videoUrl: vid.url,
                                      subTitle: "\(vid.views) views", title: vid.title,
                                      desc: vid.sport.name, date: vid.date)
            return data
        }
        let stories = data.stories.map { stor -> CollectionItem in
            let story = CollectionItem(id: stor.id, type: .story, imageURL: stor.image, videoUrl: "",
                                       subTitle: "By \(stor.author) at \(stor.date.toDataString())", title: stor.title,
                                       desc: stor.sport.name, date: stor.date)
            return story
        }
        let result: [CollectionItem] = self.mixOneByOne(videos: videos, stories: stories)
        return result
    }
    func mixOneByOne(videos: [CollectionItem], stories: [CollectionItem]) -> [CollectionItem] {
        var result: [CollectionItem] = []
        var localVideos = videos
        for story in stories {
            result.append(story)
            for (index, item) in localVideos.enumerated() {
                result.append(item)
                localVideos.remove(at: index)
                break
            }
        }
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
