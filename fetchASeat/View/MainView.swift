//
//  ContentView.swift
//  fetchASeat
//
//  Created by Aaron Pachesa on 4/26/21.
//

//SeatGeekAPI Notes:
//Client ID: client_id=MjE3OTI0OTh8MTYxOTQ2NTUxMC4zODk1NTY2
// Your app secret is "9614158889724b1d683b95cd91d776ca4af61453cd1d89d0a02959e42db0645b"
//https://api.seatgeek.com/2/events?q=boston+celtics&client_id=MjE3OTI0OTh8MTYxOTQ2NTUxMC4zODk1NTY2

import SwiftUI

//UserDefaults set up
let userDefaults = UserDefaults.standard
var savedFavorites: [Int] = userDefaults.object(forKey: "savedFavorites") as? [Int] ?? []

//View
struct MainView: View {
    
    @State private var isEditingSearchText = false
//    @State private var searchText = ""
    
//    @State var events = [Event]()
    @ObservedObject var eventViewModel = EventViewModel()
    
//    @AppStorage("isFirstStartUp") var isFirstStartUp: Bool = true
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            //Title
            Text("Fetch-a-🪑")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    print(savedFavorites)
                }
            
            HStack {
                //Custom search bar
                //TO DO: place search bar in different file...
                TextField("Search events", text: $eventViewModel.searchText)
                    .onChange(of: eventViewModel.searchText) { newValue in
//                        loadData()
                        eventViewModel.loadItLoadItGood()

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
                            if isEditingSearchText {
                                Button(action: {
                                    eventViewModel.searchText = ""
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
                        self.isEditingSearchText = true
                    }
                if isEditingSearchText {
                    Button(action: {
                        isEditingSearchText = false
                        eventViewModel.searchText = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
            //Navi and list
            NavigationView {
                
                List(eventViewModel.events, id: \.id) { event in
                    NavigationLink(destination: DetailView(event: event)) {
                        
                        VStack {
                            
                            ZStack {
                                
                                Image(systemName: "questionmark")
                                    .data(url: URL(string: "\(event.performers[0].image)")!)
                                    .aspectRatio(contentMode: .fit)
                                if savedFavorites.contains(event.id) {
                                    Image(systemName: "heart.fill")
                                        .offset(x: 150, y: -100)
                                        .font(.system(size: 40))
                                        .foregroundColor(.red)
                                } else {
                                    Image(systemName: "heart")
                                        .offset(x: 150, y: -100)
                                        .font(.system(size: 40))
                                        .foregroundColor(.red)
                                }
                            }
                            
                            Text(event.short_title)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                            
                            Spacer()
                            
                        }
                    }
                }
                .onAppear() {
//                    loadData()
                    eventViewModel.loadItLoadItGood()
                }
                .navigationTitle("")
                .navigationBarHidden(true)
            }
        }
    }
    
//    func loadData() {
//        guard let url = URL(string: "https://api.seatgeek.com/2/events?q=\(loadSearchText(input: searchText))&client_id=MjE3OTI0OTh8MTYxOTQ2NTUxMC4zODk1NTY2") else {
//            print("Invalid URL")
//            return
//        }
//        print(url)
//        let request = URLRequest(url: url)
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                if let decodedResponse = try? JSONDecoder().decode(Welcome.self, from: data) {
//                    DispatchQueue.main.async {
//                        self.events = decodedResponse.events
//                    }
//                    return
//                }
//            }
//            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
//        }.resume()
//    }
    
//    func loadSearchText(input: String) -> String {
//        if isFirstStartUp {
//            isFirstStartUp = false
//            return "did i get the job? 🥺"
//        } else {
//            return input.replacingOccurrences(of: " ", with: "+")
//        }
//    }
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
        MainView()
    }
}
