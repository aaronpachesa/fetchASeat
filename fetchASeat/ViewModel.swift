//
//  ViewModel.swift
//  fetchASeat
//
//  Created by Aaron Pachesa on 5/4/21.
//

import Foundation

class EventViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    @Published var isFirstStartUp: Bool = true
    @Published var searchText: String = ""
    
    func loadItLoadItGood() {
        guard let url = URL(string: "https://api.seatgeek.com/2/events?q=\(loadSearchText(input: searchText))&client_id=MjE3OTI0OTh8MTYxOTQ2NTUxMC4zODk1NTY2") else {
            print("Invalid URL")
            return
        }
        print(url)
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Welcome.self, from: data) {
                    DispatchQueue.main.async {
                        self.events = decodedResponse.events
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func loadSearchText(input: String) -> String {
        if isFirstStartUp {
            isFirstStartUp = false
            return "did i get the job? 🥺"
        } else {
            return input.replacingOccurrences(of: " ", with: "+")
        }
    }
    
}
