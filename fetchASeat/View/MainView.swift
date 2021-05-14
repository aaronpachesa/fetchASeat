//
//  ContentView.swift
//  fetchASeat
//
//  Created by Aaron Pachesa on 4/26/21.
//

import SwiftUI

//View
struct MainView: View {
    
    let defaults = UserDefaults.standard
    
    @State private var isEditingSearchText = false
    
    @ObservedObject var eventViewModel = EventViewModel()
        
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("blackout") var blackout = "[SavedEvent]()"

    
    var body: some View {
        
        TabView {
            //Search Tab
            VStack {
                //Title
                Text("Fetch-a-🪑")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                HStack {
                    //Custom Search Bar
                    TextField("Search events", text: $eventViewModel.searchText)
                        .onChange(of: eventViewModel.searchText) { newValue in
                            eventViewModel.loadIt()
                        }
                        .frame(width: 200)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                        .overlay(
                            HStack {
                                //Magnifying Glass
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                //"X" Button
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
                    //Cancel Button
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
                //Navigation and List
                NavigationView {
                    
                    List(eventViewModel.events, id: \.id) { event in
                        NavigationLink(destination: DetailView(event: event)) {
                            
                            VStack {
                                
                                ZStack {
                                    //"Small Image"
                                    Image(systemName: "questionmark")
                                        .loadPhoto(url: URL(string: "\(event.performers[0].image)")!)
                                        .aspectRatio(contentMode: .fit)
                                    //Save Indicator Image
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
                                //Title of Event
                                Text(event.short_title)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                
                                Spacer()
                                
                                Spacer()
                                
                            }
                        }
                    }
                    .onAppear() {
                        eventViewModel.loadIt()
                        retrieveIt()
                        print("saved favorites: \(savedFavorites)")
                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)
                }
            }
                .tabItem {
                    Label("Find", systemImage: "list.dash")
                }
//Favorites Tab
            VStack {
                Text("Fetch-a-♥️")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                List(savedObjects, id: \.id) { event in
                    
                        VStack {
                            
                            ZStack {
                                //"Small Image"
                                Image(systemName: "questionmark")
                                    .loadPhoto(url: URL(string: "\(event.image)")!)
                                    .aspectRatio(contentMode: .fit)
                                
                            }
                            //Title of Event
                            Text("\(event.short_title)")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                            
                            Spacer()
                            
                        }
                    
                }
                .onAppear() {
        //            eventViewModel.loadIt()
                    print("saved favorites: \(savedFavorites)")
                    retrieveIt()
                    
                    
                }
                
            }
            

                .tabItem {
                    Label("Favorites", systemImage: "square.and.pencil")
                }
        }
        
    }
    func retrieveIt() {
        if let savedPerson = defaults.object(forKey: "SavedObjects") as? Data {
            let decoder = JSONDecoder()
            if let events = try? decoder.decode([SavedEvent].self, from: savedPerson) {
                savedObjects = events
                return
            }
        }

    }
    
}
//Does not monitor state changes
extension Image {
    func loadPhoto(url:URL) -> Self {
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
