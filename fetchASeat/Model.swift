//
//  Model.swift
//  fetchASeat
//
//  Created by Aaron Pachesa on 5/7/21.
//

import Foundation

//Model
struct Welcome: Codable {
    let events: [Event]
}

struct Event: Codable, Identifiable {
    let id: Int
    let datetime_local: String
    let short_title: String
    let venue: Venue
    let performers: [Performer]
}

struct Venue: Codable {
    let display_location: String
}

struct Performer: Codable {
    let image: String
    let images: Huge
}

struct Huge: Codable {
    let huge: String
}
