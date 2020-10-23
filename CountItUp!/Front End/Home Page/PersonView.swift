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
            
            if person.image != nil {
                if person.image!.count != 0 {
                    Image(uiImage: UIImage(data: person.image!)!)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .cornerRadius(35)
                } else {
                    Image(systemName: "person.circle.fill")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .cornerRadius(75)
                        .foregroundColor(.secondary)
                }
            } else {
                Image(systemName: "person.circle.fill")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(75)
                    .foregroundColor(.secondary)
            }
            
            Text("\(self.person.points)")
                .font(.headline)
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }
    }
}

