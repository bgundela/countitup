//
//  AddSheetView.swift
//  CountItUp!
//
//  Created by Bhuvan Gundela on 10/12/20.
//

import SwiftUI

struct AddSheetView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var name = ""
    
    @State var pointsBinding = ""
    
    @State var showImagePicker = false
    
    @State var color = "Default"
    
    @State var profileImage: UIImage = UIImage()
    
    @State var points = 0
    
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
            
            Text("Add A New Member")
                .font(.system(size: 35))
                .fontWeight(.black)
                .foregroundColor(colorScheme == .dark ? .white : .black)
            
            TextField("Name", text: self.$name)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(self.name == "" ? Color("\(color)") : Color.black, lineWidth: 1)
                )
                .padding()
            
            TextField("Points", text: self.$pointsBinding)
                .keyboardType(.numberPad)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 30)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(self.points == 0 ? Color("\(color)") : Color.black, lineWidth: 1)
                )
                .padding()
            
            Spacer()
            
            Button(action: {
                guard let convertedPoints = Int(pointsBinding) else { return }
                
                if name != "" && profileImage != UIImage() {
                    let newPerson = Person(context: self.moc)
                    newPerson.name = name
                    newPerson.points = convertedPoints
                    newPerson.image = "profile"
                    newPerson.history = "\(newPerson.name) just got created."
                    
                    try! self.moc.save()
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Create")
                .font(.title)
                .padding()
                .foregroundColor(Color("\(color)"))
                .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                .background(Color("\(color)").opacity(0.4))
                .cornerRadius(25)
            }
            
            Spacer()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$profileImage, show: self.$showImagePicker)
        }
        .onAppear {
            guard let retrievedColor = UserDefaults.standard.value(forKey: "color") else {
                return
            }

            self.color = retrievedColor as! String
        }
    }
}

struct AddSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddSheetView()
    }
}
