//
//  ContentView.swift
//  fetchASeat
//
//  Created by Aaron Pachesa on 4/26/21.
//

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
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                            Button(action: {
                                self.isEditing = false
                                self.text = ""

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
