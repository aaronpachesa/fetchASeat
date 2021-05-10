//
//  UserDefaults.swift
//  fetchASeat
//
//  Created by Aaron Pachesa on 5/10/21.
//

import Foundation

//UserDefaults
let userDefaults = UserDefaults.standard
var savedFavorites: [Int] = userDefaults.object(forKey: "savedFavorites") as? [Int] ?? []
