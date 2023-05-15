//
//  DataModel.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import Foundation

// swiftlint:disable identifier_name
struct APIResponse: Codable {
    var videos: [Video]
    var stories: [Story]
}
struct Video: Codable {
    var id: Int
    var title: String
    var thumb: String
    var url: String
    var date: Int
    var sport: Sport
    var view: Int
}
struct Story: Codable {
    var id: Int
    var title: String
    var teaser: String
    var image: String
    var date: Int
    var author: String
    var sport: Sport
}
struct Sport: Codable {
    var id: Int
    var name: String
}
