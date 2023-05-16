//
//  DataModel.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import Foundation

// swiftlint:disable identifier_name
enum Type {
case story
case video
}

struct CollectionItem: Identifiable, Hashable {
    var id: Int
    var type: Type
    var imageURL: String
    var videoUrl: String
    var subTitle: String
    var title: String
    var desc: String
    var date: Double
}

struct APIResponse: Codable {
    var videos: [Video]
    var stories: [Story]
}
struct Video: Codable {
    var id: Int
    var title: String
    var thumb: String
    var url: String
    var date: Double
    var sport: Sport
    var views: Int
}
struct Story: Codable {
    var id: Int
    var title: String
    var teaser: String
    var image: String
    var date: Double
    var author: String
    var sport: Sport
}
struct Sport: Codable {
    var id: Int
    var name: String
}
