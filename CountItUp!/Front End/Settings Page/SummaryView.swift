//
//  SummaryView.swift
//  CountItUp!
//
//  Created by Bhuvan Gundela on 10/17/20.
//

import SwiftUI

struct SummaryView: View {
    @Binding var color: String
    @Environment(\.presentationMode) var presentationMode
    @Binding var summary: String
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Close")
                        .fontWeight(.black)
                        .foregroundColor(Color("\(color)"))
                }
                .padding()
                
                Spacer()
                
                Text("Summary")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color("\(self.color)"))
                    .fontWeight(.heavy)
                
                Spacer()
            }
            
            Spacer()
            
            if summary == "" {
                Text("No Summary Yet.")
                    .font(.headline)
                    .foregroundColor(Color("\(color)"))
                    .padding()
            } else {
                Text("\(summary)")
                    .font(.headline)
                    .foregroundColor(Color("\(color)"))
                    .padding()
            }
            
            Spacer()
        }
    }
}
