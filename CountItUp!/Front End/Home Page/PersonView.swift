//
//  PersonView.swift
//  CountItUp!
//
//  Created by Bhuvan Gundela on 10/12/20.
//

import SwiftUI

struct PersonView: View {
    var person: Person
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 10) {
            Text("\(self.person.name)")
                .font(.headline)
                .fontWeight(.black)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            
            Image(uiImage: UIImage(data: person.image)!)
                .renderingMode(.original)
                .resizable()
                .frame(width: 70, height: 70)
                .cornerRadius(35)
            
            Text("\(self.person.points)")
                .font(.headline)
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
    }
}

