//
//  ModifySheetView.swift
//  CountItUp!
//
//  Created by Bhuvan Gundela on 10/12/20.
//

import SwiftUI

struct ModifySheetView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode

    @State var showImagePicker = false

    @State var newName = ""
    
    @State var newPoints = ""
    
    @State var person: Person

    @State var color = "Default"

    @State var profileImage = UIImage()
    
    @Binding var indexSet: Int
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Person.getAllPeople()) var people: FetchedResults<Person>

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .fontWeight(.black)
                        .foregroundColor(Color("\(color)"))
                }

                Spacer()
            }
            .padding()

            Spacer()

            Button(action: {
                self.showImagePicker = true
            }) {
                if profileImage != UIImage() {
                    Image(uiImage: profileImage)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .cornerRadius(50)

                } else {
                    Image(systemName: "camera")
                        .font(.title)
                        .padding()
                        .foregroundColor(Color("\(color)"))
                        .frame(width: 150, height: 150)
                        .background(Color("\(color)").opacity(0.4))
                        .cornerRadius(50)
                }
            }

            Text("Modify \(self.person.name): \(self.person.points)")
                .font(.system(size: 35))
                .fontWeight(.black)
                .foregroundColor(colorScheme == .dark ? .white : .black)

            TextField("New Name", text: self.$newName)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(self.person.name == "" ? Color("\(color)") : Color.black, lineWidth: 1)
                )
                .padding()

            TextField("New Points", text: $newPoints)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(self.person.points == 0 ? Color("\(color)") : Color.black, lineWidth: 1)
                )
                .padding()

            Spacer()

            Button(action: {
                guard let convertedPoints = Int(newPoints) else { return }
                
                if newName != person.name && newName != "" {
                    DispatchQueue.main.async {
                        self.people[indexSet].history = "\(person.name)'s name was changed to \(newName)"
                        
                        self.updateValue(at: self.indexSet, update: "name", to: self.newName)
                    }
                }
                
                if convertedPoints != person.points {
                    DispatchQueue.main.async {
                        self.updateValue(at: self.indexSet, update: "points", to: convertedPoints)
                    }
                    
                    self.people[indexSet].history = "\(self.people[indexSet].name)'s points were changed to \(self.people[indexSet].points)"
                }
                
                self.presentationMode.wrappedValue.dismiss()
                
            }) {
                Text("Modify")
                    .font(.title)
                    .padding()
                    .foregroundColor(Color("\(color)"))
                        .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                    .background(Color("\(color)").opacity(0.4))
                    .cornerRadius(25)
            }

            Spacer()
            
        }
        .onAppear {
            guard let retrievedColor = UserDefaults.standard.value(forKey: "color") else {
                return
            }

            self.color = retrievedColor as! String
        }
    }
    
    func updateValue(at indexSet: Int, update key: String, to value: Any) {
        let updateItem = self.people[indexSet]
        updateItem.setValue(value, forKey: key)
        
        try! self.moc.save()
    }
}
