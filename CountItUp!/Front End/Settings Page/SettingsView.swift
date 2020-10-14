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
    
    @State var resetOption = 0
    @State var resetOptions = ["No Reset", "Reset after a day", "Reset after a week", "Reset after a month", "Reset after a quarter of a year", "Reset after half a year", "Reset after a year"]
    
    @State var color = "Default"
    
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
                    
                    Section {
                        Picker(selection: self.$resetOption, label: Text("Reset Options")) {
                            ForEach(0..<self.resetOptions.count) {
                                Text("\(self.resetOptions[$0])").tag($0)
                            }
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
                    
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    UserDefaults.standard.setValue(increment, forKey: "increment")
                    UserDefaults.standard.setValue(resetOption, forKey: "reset")
                    UserDefaults.standard.setValue(color, forKey: "color")
                    
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
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
