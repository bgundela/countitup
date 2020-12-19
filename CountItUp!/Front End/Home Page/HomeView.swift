//
//  HomeView.swift
//  CountItUp!
//
//  Created by Bhuvan Gundela on 10/12/20.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Person.getAllPeople()) var people: FetchedResults<Person>
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var activeSheet: ActiveSheet = .create
    
    @State var color = "Default"
    
    @State var indexSet = 0
    
    @State var increment = 0
    
    @State var increments = [1, 2, 3, 4, 5, 10, 20, 50, 100, 500, 1000]
    
    @State var resetIt = false
    
    @State var resetMonth = 0
    
    @State var title = ""
    
    @State var msg = ""
    
    @State var presentAlert = false
    
    @State var checkLeft = false
    
    @State var checkRight = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                Color("\(color)")
                    .edgesIgnoringSafeArea(.top)
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                
                HStack {
                    Text("Count It Up!")
                        .bold()
                        .font(.system(size: 40))
                        .padding()
                }
            }
            
            Spacer()
            
            VStack {
                Text("\(self.getDate())")
                    .bold()
                    .font(.title)
            }
            
            HStack {
                Text("Points Manager")
                    .font(.title)
                
                Spacer()
                
            }
            .padding()
            
            HStack {
                Button(action: {
                    if indexSet > 0 {
                        self.indexSet -= 1
                        checkLeft = false
                    } else {
                        checkLeft = true
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 37, height: 45)
                        .foregroundColor(self.checkLeft ? Color("\(color)").opacity(0.5) : Color("\(color)"))
                        .padding()
                }
                
                Spacer()
               
                if self.people.isEmpty {
                
                } else {
                    VStack {
                        Text("\(self.people[indexSet].name)")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        if self.people[indexSet].image != nil {
                            if self.people[indexSet].image!.count != 0 {
                                Image(uiImage: UIImage(data: self.people[indexSet].image!)!)
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(75)
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
                    }
                }
                
                Spacer()
                
                Button(action: {
                    if indexSet < self.people.count - 1 {
                        self.indexSet += 1
                        checkRight = false
                    } else {
                        checkRight = true
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 37, height: 45)
                        .foregroundColor(self.checkRight ? Color("\(color)").opacity(0.5) : Color("\(color)"))
                        .padding()
                }
            }
            
            
            if self.people.isEmpty {
                Text("There is nobody in the group.")
            } else {
                VStack {
                    
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            self.people[indexSet].points -= increment
                            
                            self.people[indexSet].history = "\(getDate()) \(getTime()): Points were changed to \(self.people[indexSet].points)"
                            
                            do {
                                try self.moc.save()
                            } catch {
                                self.title = "Error"
                                self.msg = "An error has occured while subtracting \(self.people[indexSet].name)'s points. Please try again later. If this error persists please contact 'countitup@gmail.com'."
                                self.presentAlert.toggle()
                            }
                            
                        }) {
                            Text("-")
                                .font(.system(size: 75))
                                .frame(width: 45, height: 37)
                                .foregroundColor(Color("\(color)"))
                                .padding()
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("\(self.people[indexSet].points)")
                                .fontWeight(.heavy)
                                .font(.system(size: 35))
                                .font(.headline)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            self.people[indexSet].points += increment
                            
                            self.people[indexSet].history = "\(getDate()) \(getTime()): Points were changed to \(self.people[indexSet].points)"
                            
                            do {
                                try self.moc.save()
                            } catch {
                                self.title = "Error"
                                self.msg = "An error has occured while adding \(self.people[indexSet].name)'s points. Please try again later. If this error persists please contact 'countitup@gmail.com'."
                                self.presentAlert.toggle()
                            }
                            
                            
                        }) {
                            Text("+")
                                .font(.system(size: 75))
                                .frame(width: 45, height: 37)
                                .foregroundColor(Color("\(color)"))
                                .padding()
                        }
                        
                        Spacer()
                    }
                    .padding()
                    
                }
                .padding()
            }
            
            Spacer()
        }
        .onAppear {
            guard let retrievedIncrement = UserDefaults.standard.value(forKey: "increment") else {
                return
            }

            let recievedIncrement = retrievedIncrement as! Int

            self.increment = self.increments[recievedIncrement]

            guard let retrievedColor = UserDefaults.standard.value(forKey: "color") else {
                return
            }

            self.color = retrievedColor as! String

            guard let retrievedReset = UserDefaults.standard.value(forKey: "resetIt") else {
                return
            }

            self.resetIt = retrievedReset as! Bool

            guard let retreivedResetMonth = UserDefaults.standard.value(forKey: "getToMonth") else {
                return
            }

            self.resetMonth = retreivedResetMonth as! Int

            print("Initialized")
            print(self.resetMonth)

            if self.resetIt == true {
                self.reset()
            }
        }
        .alert(isPresented: self.$presentAlert) {
            Alert(title: Text("\(self.title)"), message: Text("\(self.msg)"), dismissButton: .default(Text("Ok")))
        }
    }
    
    func updateValue(at indexSet: Int, update key: String, to value: Any) {
        let updateItem = self.people[indexSet]
        updateItem.setValue(value, forKey: key)
        
        try! self.moc.save()
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
    
    func reset() {
        if Calendar.current.component(.month, from: Date()) == self.resetMonth {
            let monthStr = Calendar.current.monthSymbols[self.resetMonth]
            
            var summaryString = "In \(monthStr), "
            
            for person in self.people {
                summaryString.append("\(person.name) had \(person.points) points. ")
            }
            
            UserDefaults.standard.setValue(summaryString, forKey: "summary")
            
            for person in self.people {
                person.points = 0
                try! self.moc.save()
            }
            
            let monthNum = self.resetMonth
            
            if monthNum == 12 {
                resetMonth = 1
            } else {
                resetMonth = monthNum + 1
            }
            
            UserDefaults.standard.setValue(self.resetMonth, forKey: "getToMonth")
        }
//        let oneMonth = Calendar.current.date(byAdding: .second, value: 5, to: date)
//        let run = true
//
//
//        let currentMonth = Calendar.current.dateComponents([.second], from: date)
//        let getToMonth = Calendar.current.dateComponents([.second], from: oneMonth ?? Date())
//
//        print("\(Calendar.current.dateComponents([.second], from: Date()))")
//        print("\(getToMonth)")
//
//        while run {
//            if Calendar.current.dateComponents([.second], from: Date()) == getToMonth {
//                print("Here")
//                write(date: date, currentMonth: currentMonth)
//                break
//            }
//        }
        
        // Seconds in a Month: 2628000
    }
    
    func write(date: Date, currentMonth: DateComponents) {
        print("Here: \(date)")
        print("Now: \(currentMonth)")
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
