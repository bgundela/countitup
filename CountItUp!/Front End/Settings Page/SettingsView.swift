//
//  SettingsView.swift
//  CountItUp!
//
//  Created by Bhuvan Gundela on 10/12/20.
//

import SwiftUI

struct SettingsView: View {
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    @State var increment = 0
    @State var increments = [1, 2, 3, 4, 5, 10, 20, 50, 100, 500, 1000]
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Person.getAllPeople()) var people: FetchedResults<Person>
    
    @State var resetIt = false
    
    @State var color = "Default"
    
    @State var resetMonth = 0
    
    @State var title = ""
    
    @State var msg = ""
    
    @State var presentAlert = false
    
    @State var summary = ""
    
    @State var show = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .bottomLeading) {
                    Color("\(color)")
                        .edgesIgnoringSafeArea(.top)
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                    
                    HStack {
                        Text("Settings")
                            .bold()
                            .font(.system(size: 40))
                            .padding()
                    }
                }
                
                Form {
                    Section {
                        Picker(selection: self.$increment, label: Text("Increment")) {
                            ForEach(0..<self.increments.count) {
                                Text("\(self.increments[$0])").tag($0)
                            }
                        }
                        .padding(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("\(color)"), lineWidth: 1)
                        )
                    }
                    
                    NavigationLink(destination: UserManual(color: self.$color)) {
                        Text("User Manual")
                    }
                    .padding(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color("\(color)"), lineWidth: 1)
                    )
                    
                    
                    Section {
                        Toggle(isOn: $resetIt) {
                            Text("Reset after Each Month: ")
                        }
                        .padding(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("\(color)"), lineWidth: 1)
                        )
                    }
                    
                    NavigationLink(destination: VStack {
                        HStack {
                            Text("Main Color")
                                .bold()
                                .fontWeight(.black)
                                .font(.title)
                        }
                        
                        HStack {
                            Button(action: {
                                self.color = "Red"
                            }) {
                                if self.color == "Red" {
                                    Rectangle()
                                        .fill(Color("Red"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                        .border(Color("Normal"), width: 3)
                                } else {
                                    Rectangle()
                                        .fill(Color("Red"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                }
                            }
                            
                            Button(action: {
                                self.color = "Orange"
                            }) {
                                if self.color == "Orange" {
                                    Rectangle()
                                        .fill(Color("Orange"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                        .border(Color("Normal"), width: 3)
                                } else {
                                    Rectangle()
                                        .fill(Color("Orange"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                }
                            }
                            
                            Button(action: {
                                self.color = "Yellow"
                            }) {
                                if self.color == "Yellow" {
                                    Rectangle()
                                        .fill(Color("Yellow"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                        .border(Color("Normal"), width: 3)
                                } else {
                                    Rectangle()
                                        .fill(Color("Yellow"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                }
                            }
                            
                            Button(action: {
                                self.color = "Green"
                            }) {
                                if self.color == "Green" {
                                    Rectangle()
                                        .fill(Color("Green"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                        .border(Color("Normal"), width: 3)
                                } else {
                                    Rectangle()
                                        .fill(Color("Green"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                }
                            }
                            
                        }
                        .padding()
                        
                        HStack {
                            Button(action: {
                                self.color = "Blue"
                            }) {
                                if self.color == "Blue" {
                                    Rectangle()
                                        .fill(Color("Blue"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                        .border(Color("Normal"), width: 3)
                                } else {
                                    Rectangle()
                                        .fill(Color("Blue"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                }
                            }
                            
                            Button(action: {
                                self.color = "Purple"
                            }) {
                                if self.color == "Purple" {
                                    Rectangle()
                                        .fill(Color("Purple"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                        .border(Color("Normal"), width: 3)
                                } else {
                                    Rectangle()
                                        .fill(Color("Purple"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                }
                            }
                            
                            Button(action: {
                                self.color = "Pink"
                            }) {
                                if self.color == "Pink" {
                                    Rectangle()
                                        .fill(Color("Pink"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                        .border(Color("Normal"), width: 3)
                                } else {
                                    Rectangle()
                                        .fill(Color("Pink"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                }
                            }
                            
                            Button(action: {
                                self.color = "Default"
                            }) {
                                if self.color == "Default" {
                                    Rectangle()
                                        .fill(Color("Default"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                        .border(Color("Normal"), width: 3)
                                } else {
                                    Rectangle()
                                        .fill(Color("Default"))
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)
                                }
                            }
                            
                        }
                        .padding()
                    }, label: {
                            Text("Main Color")
                        }
                    )
                    .padding(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color("\(color)"), lineWidth: 1)
                    )
                    
                    Section {
                        if self.resetIt == true {
                            Button(action: {
                                self.show.toggle()
                            }) {
                                Text("Show Monthly Summary")
                                    .padding()
                                    .foregroundColor(Color("\(self.color)"))
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color("\(color)"), lineWidth: 1)
                            )
                        }
                    }
                    
                    Section {
                        Button(action: {
                            if self.people.isEmpty {
                                print("Empty")
                            } else {
                                for person in self.people {
                                    person.history = "No History"
                                }
                                
                                do {
                                    try self.moc.save()
                                    
                                    self.title = "Success"
                                    self.msg = "Successfully deleted all members' history."
                                    self.presentAlert.toggle()
                                    
                                } catch {
                                    self.title = "Error"
                                    self.msg = "An error has occured while deleting everybody's history. The action may or may not have worked. If not, please try again later. If this error persists please contact 'countitup@gmail.com'."
                                    self.presentAlert.toggle()
                                }
                            }
                        }) {
                            Text("Delete All History")
                                .padding()
                                .foregroundColor(Color("\(self.color)"))
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("\(color)"), lineWidth: 1)
                        )
                    }
                    
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    UserDefaults.standard.setValue(increment, forKey: "increment")
                    UserDefaults.standard.setValue(resetIt, forKey: "resetIt")
                    UserDefaults.standard.setValue(color, forKey: "color")
                    self.resetMonth = self.calculateResetMonth(calendar: Calendar.current)
                    
                }) {
                    Text("Save")
                        .foregroundColor(Color("\(color)"))
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            guard let retrievedIncrement = UserDefaults.standard.value(forKey: "increment") else {
                return
            }
            
            self.increment = retrievedIncrement as! Int
            
            guard let retreivedColor = UserDefaults.standard.value(forKey: "color") else {
                return
            }
            
            self.color = retreivedColor as! String
            
            guard let retreivedReset = UserDefaults.standard.value(forKey: "resetIt") else {
                return
            }
            
            self.resetIt = retreivedReset as! Bool
            
            guard let retreivedResetMonth = UserDefaults.standard.value(forKey: "getToMonth") else {
                return
            }
            
            self.resetMonth = retreivedResetMonth as! Int
            
            guard let retrievedSummary = UserDefaults.standard.value(forKey: "summary") else {
                return
            }
            
            self.summary = retrievedSummary as! String
        }
        .alert(isPresented: self.$presentAlert) {
            Alert(title: Text("\(self.title)"), message: Text("\(self.msg)"), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: self.$show) {
            SummaryView(color: self.$color, summary: self.$summary)
        }
    }
    
    func calculateResetMonth(calendar: Calendar) -> Int {
        let calendar = calendar
        let date = Date()
        
        let monthNum = calendar.component(.month, from: date)
        var getToMonth = 0
        let months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        for item in months {
            if monthNum == months[11] {
                getToMonth = months[0]
            } else {
                getToMonth = monthNum + 1
            }
        }
        
        UserDefaults.standard.setValue(getToMonth, forKey: "getToMonth")
        
        return getToMonth
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
