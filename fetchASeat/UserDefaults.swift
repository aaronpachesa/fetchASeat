//
//  UserDefaults.swift
//  fetchASeat
//
//  Created by Aaron Pachesa on 5/10/21.
//

import Foundation

//UserDefaults
let userDefaults = UserDefaults.standard
//as? is asking Swift to typecast to see if UserDefaults can be saved as an array
var savedFavorites: [Int] = userDefaults.object(forKey: "savedFavorites") as? [Int] ?? []
//var savedFavoriteObjects: [SavedEvent] = userDefaults.object(forKey: "savedFavoriteObjects") as? [SavedEvent] ?? []
var savedFavoriteObjects: [SavedEvent] =  []
var objects: [SavedEvent] =  []
