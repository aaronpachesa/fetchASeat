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
//Football

import SwiftUI

struct Welcome: Codable {
    let events: [Event]
}

struct Event: Codable, Identifiable {
    let id: Int
    let datetime_local: String
    let short_title: String
    let description: String
    let venue: Venue
    let performers: [Performer]
}

struct Venue: Codable {
    let display_location: String
}

struct Performer: Codable {
    let image: String
}

struct ContentView: View {
    @State private var isEditing = false
    @State private var searchText = ""
    @State var events = [Event]()
    @State private var notFoundAlert = false
    var body: some View {
        VStack {
            HStack {
                Button("do it") {
                    loadData()
                }
                TextField("Search events", text: $searchText)
                    //                    .onChange(of: searchText) { newValue in
                    //
                    //                                }
                    
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
                                    self.searchText = ""
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
                        self.searchText = ""
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
                List(events, id: \.id) { event in
                    NavigationLink(destination: DetailView(event: event)) {
                        VStack {
                            Text(event.short_title)
                            Image(systemName: "person.fill")
                                .data(url: URL(string: "\(event.performers[0].image)")!)
                        }
                    }
                }
                .navigationTitle("fetchASeat")
            }
        }
    }
    
    func loadData() {
        guard let url = URL(string: "https://api.seatgeek.com/2/events?q=\(searchText)&client_id=MjE3OTI0OTh8MTYxOTQ2NTUxMC4zODk1NTY2") else {
            print("Invalid URL")
            
            return
        }
        print(url)
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print("b")
                if let decodedResponse = try? JSONDecoder().decode(Welcome.self, from: data) {
                    print("c")
                    DispatchQueue.main.async {
                        self.events = decodedResponse.events
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct DetailView: View {
    var event: Event
    var body: some View {
        VStack {
            Image(systemName: "heart")
            Text(event.description)
        }
    }
}

extension Image {
    func data(url:URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
