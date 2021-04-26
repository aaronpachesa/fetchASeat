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
            TextField("Search ...", text: $text)
                .padding(7)
//                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .foregroundColor(.gray)
                .cornerRadius(8)
//                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
