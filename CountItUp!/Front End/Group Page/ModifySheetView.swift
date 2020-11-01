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

    @State var profileImage: Data = .init(count: 0)
    
    @Binding var indexSet: Int
    
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
                if self.person.image != nil {
                    if self.person.image!.count != 0 {
                        if profileImage.count != 0 {
                            Image(uiImage: UIImage(data: profileImage)!)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .cornerRadius(50)

                        } else {
                            Image(uiImage: UIImage(data: self.person.image!)!)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .cornerRadius(50)
                        }
                    } else {
                        Image(systemName: "camera")
                            .font(.title)
                            .padding()
                            .foregroundColor(Color("\(color)"))
                            .frame(width: 150, height: 150)
                            .background(Color("\(color)").opacity(0.4))
                            .cornerRadius(50)
                    }
                } else {
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
                
                var check = true
                
                for person in self.people {
                    if person.name == self.newName {
                        check = false
                    }
                }
                
                if newName != person.name && newName != "" && check {
                    DispatchQueue.main.async {
                        self.updateValue(at: indexSet, update: "name", to: newName)
                    }
                    
                    self.people[indexSet].history = "\(person.name)'s name was changed to \(newName)."
                    
                    self.title = "Success"
                    self.msg = "The name has been successfully updated."
                    self.presentAlert.toggle()
                }
                
                if convertedPoints != person.points {
                    DispatchQueue.main.async {
                        self.updateValue(at: self.indexSet, update: "points", to: convertedPoints)
                    }
                    
                    self.people[indexSet].history = "\(self.people[indexSet].name)'s points were changed to \(self.people[indexSet].points)"
                }
                
                if profileImage != person.image && profileImage.count != 0 {
                    DispatchQueue.main.async {
                        self.people[indexSet].history = "\(person.name)'s image was changed."
                        
                        self.people[indexSet].image = profileImage
                        
                        do {
                            try self.moc.save()
                        } catch {
                            self.title = "Error"
                            self.msg = "An error has occured while updating \(self.people[indexSet].name). The action may or may not have worked. If not, please try again later. If this error persists please contact 'countitup@gmail.com'."
                            self.presentAlert.toggle()
                        }
                    }
                    
                    self.title = "Success"
                    self.msg = "The image has been successfully updated."
                    self.presentAlert.toggle()
                }
                
                if check != true {
                    self.title = "Message"
                    self.msg = "You already have a member named \(self.newName). Please enter a different name."
                    self.presentAlert.toggle()
                }
                
                self.title = "Success"
                self.msg = "The profile has been successfully updated."
                self.presentAlert.toggle()
                
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
            
            self.newName = self.person.name
            
            self.newPoints = "\(self.person.points)"
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(show: self.$showImagePicker, image: self.$profileImage)
        }
        .alert(isPresented: self.$presentAlert) {
            Alert(title: Text("\(self.title)"), message: Text("\(self.msg)"), dismissButton: .default(Text("Ok")))
        }
    }
    
    func updateValue(at indexSet: Int, update key: String, to value: Any) {
        let updateItem = self.people[indexSet]
        updateItem.setValue(value, forKey: key)
        
        do {
            try self.moc.save()
        } catch {
            self.title = "Error"
            self.msg = "An error has occured while updating \(self.people[indexSet].name). The action may or may not have worked. If not, please try again later. If this error persists please contact 'countitup@gmail.com'."
            self.presentAlert.toggle()
        }
        
        self.title = "Success"
        self.msg = "The profile has been successfully updated."
        self.presentAlert.toggle()
    }
}
