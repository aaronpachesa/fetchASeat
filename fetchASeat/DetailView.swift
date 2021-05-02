//
//  DetailView.swift
//  fetchASeat
//
//  Created by Aaron Pachesa on 4/29/21.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("easterEggCount") var easterEggCount: Int = 0
    
    @State private var firstEasterEggAlert = false
    @State private var secondEasterEggAlert = false
    @State private var thirdEasterEggAlert = false
    
    var event: Event
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .top) {
                
                Image(systemName: "questionmark")
                    .data(url: URL(string: "\(event.performers[0].images.huge)")!)
                    .aspectRatio(contentMode: .fit)
                    .alert(isPresented: $firstEasterEggAlert) {
                        Alert(title: Text("Nothing to see here"), dismissButton: .default(Text("Okay")))
                    }
                
                Button(action: {
                    if saveArray.contains(event.id) {
                        print("Save button was tapped")
                        saveArray.removeAll(where: { $0 == event.id })
                        userDefaults.set(saveArray, forKey: "saveArray")
                        print(saveArray)
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        print("Save button was tapped")
                        saveArray.append(event.id)
                        userDefaults.set(saveArray, forKey: "saveArray")
                        print(saveArray)
                        presentationMode.wrappedValue.dismiss()
                        
                    }
                }) {
                    saveArray.contains(event.id) ? Image(systemName: "heart.fill") : Image(systemName: "heart")
                }
                .offset(x: 150, y: 20)
                .font(.system(size: 40))
                .alert(isPresented: $secondEasterEggAlert) {
                    Alert(title: Text("Please don't tap this button again"), dismissButton: .default(Text("Okay")))
                }
            }
            
            Text(event.short_title)
                .font(.title).bold()
                .padding(.bottom, 3)
                .multilineTextAlignment(.center)
            
            Text("\(formatDate(input: event.datetime_local))")
            
            Text(event.venue.display_location)
                .alert(isPresented: $thirdEasterEggAlert) {
                    Alert(title: Text("You found my easter egg! -Aaron Pachesa"), message: Text("🥚"), dismissButton: .default(Text("Okay")))
                }
            
            Spacer()
            
            Button {
                if easterEggCount == 0 {
                    firstEasterEggAlert.toggle()
                } else if easterEggCount == 1 {
                    secondEasterEggAlert.toggle()
                } else if easterEggCount == 2 {
                    thirdEasterEggAlert.toggle()
                    easterEggCount = -1
                }
                easterEggCount += 1
                presentationMode.wrappedValue.dismiss()
                
            } label: {
                Image(systemName: "key")
            }
        }
    }
    
    func formatDate(input: String) -> String {
        
        //going from string to date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"
        let date = formatter.date(from: input) ?? Date()
        
        //going from date to string
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "MMM d 'at' h:mma"
        
        return formatter2.string(from: date)
    }
}
