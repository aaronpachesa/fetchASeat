//
//  ContentView.swift
//  fetchASeat
//
//  Created by Aaron Pachesa on 4/26/21.
//

//Client ID:    client_id=MjE3OTI0OTh8MTYxOTQ2NTUxMC4zODk1NTY2
// Your app secret is "9614158889724b1d683b95cd91d776ca4af61453cd1d89d0a02959e42db0645b" - copy now as it can't be retrieved later.
//https://api.seatgeek.com/2/events?q=boston+celtics&client_id=MjE3OTI0OTh8MTYxOTQ2NTUxMC4zODk1NTY2

import SwiftUI

struct ContentView: View {
    @State private var isEditing = false
    @State private var text = ""
    var body: some View {
        HStack {
            TextField("Search events", text: $text)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
