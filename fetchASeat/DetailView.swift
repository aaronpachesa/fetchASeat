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
    @State private var saveFill = false
    
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
            
            Text(event.venue.display_location)
                .padding(.top, 5)
                .alert(isPresented: $thirdEasterEggAlert) {
                    Alert(title: Text("Your found my easter egg! -Aaron Pachesa"), message: Text("🥚"), dismissButton: .default(Text("Okay")))
                }
            
            Text(event.datetime_local)
            
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
}
