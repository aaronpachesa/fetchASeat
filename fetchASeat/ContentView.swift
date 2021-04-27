//
//  ContentView.swift
//  fetchASeat
//
//  Created by Aaron Pachesa on 4/26/21.
//

//Notes:
//Client ID:    client_id=MjE3OTI0OTh8MTYxOTQ2NTUxMC4zODk1NTY2
// Your app secret is "9614158889724b1d683b95cd91d776ca4af61453cd1d89d0a02959e42db0645b" - copy now as it can't be retrieved later.
//https://api.seatgeek.com/2/events?q=boston+celtics&client_id=MjE3OTI0OTh8MTYxOTQ2NTUxMC4zODk1NTY2

import SwiftUI

struct Welcome: Codable {
    let events: [Event]
}

struct Event: Codable, Identifiable {
    let id: Int
    let datetime_local: String
    let shortTitle: String
    let eventDescription: String
    let venue: Venue
    let performers: [Performer]
}

struct Venue: Codable {
    let displayLocation: String
}

struct Performer: Codable {
    let image: String
}

struct ContentView: View {
    @State private var isEditing = false
    @State private var text = ""
    @State private var theEvents = [Event]()
    @State private var notFoundAlert = false
    var body: some View {
        VStack {
            HStack {
                TextField("Search events", text: $text)
                    .alert(isPresented: $notFoundAlert) {
                        Alert(title: Text("We couldn't find that 🥺"), message: Text("Please try again"), dismissButton: .default(Text("Okay")))
                    }
                    .frame(width: 200)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .foregroundColor(.gray)
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                            
                            if isEditing {
                                Button(action: {
                                    self.text = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isEditing = true
                    }
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.text = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
            NavigationView {
                List(theEvents, id: \.id) { event in
                    NavigationLink(destination: DetailView(event: event)) {
                    }
                }
                .navigationTitle("fetchASeat")
            }
        }
    }
    func loadData() {
        guard let url = URL(string: "https://api.seatgeek.com/2/events?q=\(text)&client_id=MjE3OTI0OTh8MTYxOTQ2NTUxMC4zODk1NTY2") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Welcome.self, from: data) {
                    DispatchQueue.main.async {
                        self.theEvents = decodedResponse.events
                    }
                    return
                }
            }
            notFoundAlert.toggle()
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct DetailView: View {
    var event: Event
    var body: some View {
        VStack {
            Image(systemName: "heart")
            Text(event.eventDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
