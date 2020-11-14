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
    
    @State var profileImage: Data = .init(count: 0)
    
    @State var points = 0
    
    @State var title = ""
    
    @State var msg = ""
    
    @State var presentAlert = false
    
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
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                        .fontWeight(.black)
                        .foregroundColor(Color("\(color)"))
                }
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                self.showImagePicker = true
            }) {
                if profileImage.count != 0 {
                    Image(uiImage: UIImage(data: profileImage)!)
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
                guard let convertedPoints = Int(pointsBinding) else {
                    return
                }
                
                var check = true
                
                for person in self.people {
                    if person.name.lowercased() == self.name.lowercased() {
                        check = false
                    }
                }
                
                if name != "" && check && convertedPoints <= 9999 {
                    let newPerson = Person(context: self.moc)
                    newPerson.name = name
                    newPerson.points = convertedPoints
                    if profileImage.count != 0 {
                        newPerson.image = self.profileImage
                    }
                    newPerson.history = "\(self.getDate()) at \(self.getTime()): Got created."
                    
                    do {
                        try self.moc.save()
                    } catch {
                        self.title = "Error"
                        self.msg = "An error has occured while creating \(newPerson.name). Please try again later. If this error persists please contact 'countitup@gmail.com'."
                        self.presentAlert.toggle()
                    }
                    
                    self.name = ""
                    self.points = 0
                    self.pointsBinding = ""
                    self.profileImage.count = 0
                    
                    self.title = "Success"
                    self.msg = "A new member has been successfully added."
                    self.presentAlert.toggle()
                    
                } else if name == "" {
                    self.title = "Message"
                    self.msg = "Please fill in all the fields. Name is required."
                    self.presentAlert.toggle()
                } else if check == false {
                    self.title = "Message"
                    self.msg = "You already have a member named \(self.name). Please enter a different name."
                    self.presentAlert.toggle()
                } else {
                    self.title = "Message"
                    self.msg = "Your points are too high. Please enter a number under 9,999."
                    self.presentAlert.toggle()
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
            ImagePicker(show: self.$showImagePicker, image: self.$profileImage)
        }
        .onAppear {
            guard let retrievedColor = UserDefaults.standard.value(forKey: "color") else {
                return
            }

            self.color = retrievedColor as! String
        }
        .alert(isPresented: self.$presentAlert) {
            Alert(title: Text("\(self.title)"), message: Text("\(self.msg)"), dismissButton: .default(Text("OK")))
        }
    }
    
    func getDate() -> String {
        let datenow = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: datenow)
    }
    
    func getTime() -> String {
        let datenow = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: datenow)
        
    }
}
