//
//  Model.swift
//  fetchASeat
//
//  Created by Aaron Pachesa on 5/7/21.
//

import Foundation

//Model for Event
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

//Model for SavedEvent
struct SavedEvent: Codable, Equatable {
    let image: String
    let id: Int
    let short_title: String
}
