//
//  UserDefaults.swift
//  fetchASeat
//
//  Created by Aaron Pachesa on 5/10/21.
//

import Foundation

//UserDefaults and Global Variables
let userDefaults = UserDefaults.standard
var savedFavorites: [Int] = userDefaults.object(forKey: "savedFavorites") as? [Int] ?? []

var savedObjects: [SavedEvent] =  []

//var stored: Data = userDefaults.object(forKey: "stored") as? [SavedEvent] ?? []

//TODO: I don't need a saved event...
var saveItHere: [Event] =  []
