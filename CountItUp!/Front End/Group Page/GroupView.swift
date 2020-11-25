//
//  GroupView.swift
//  CountItUp!
//
//  Created by Bhuvan Gundela on 10/12/20.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case create
    case modify
    
    var id: Int {
        hashValue
    }
}

struct GroupView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: Person.getAllPeople()) var people: FetchedResults<Person>
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var activeSheet: ActiveSheet?
    
    @State var color = "Default"
    
    @State var indexSet = 0
    
    @State var title = ""
    
    @State var msg = ""
    
    @State var presentAlert = false
    
    @State var showActionSheet = false
    
    @State var checkLeft = false
    
    @State var checkRight = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                Color("\(color)")
                    .edgesIgnoringSafeArea(.top)
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                
                HStack {
                    Text("My Group")
                        .bold()
                        .font(.system(size: 40))
                        .padding()
                }
            }
            
            Spacer()
            
            Button(action: {
                self.activeSheet = .create
                
            }) {
                Text("Add A Member")
                .font(.title)
                .padding()
                .foregroundColor(Color("\(color)"))
                .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                .background(Color("\(color)").opacity(0.4))
                .cornerRadius(25)
            }
            
            HStack {
                Text("Members")
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
                VStack {
                    Text("\(self.people[indexSet].name): \(self.people[indexSet].points)")
                        .font(.title)
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
                            self.activeSheet = .modify
                        }) {
                            Image(systemName: "square.and.pencil")
                                .font(.title)
                                .padding()
                                .foregroundColor(Color("\(color)"))
                                .frame(width: 150, height: 50)
                                .background(Color("\(color)").opacity(0.4))
                                .cornerRadius(25)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            self.showActionSheet.toggle()
                        }) {
                            Image(systemName: "trash.fill")
                                .font(.title)
                                .padding()
                                .foregroundColor(Color("\(color)"))
                                .frame(width: 150, height: 50)
                                .background(Color("\(color)").opacity(0.4))
                                .cornerRadius(25)
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .sheet(item: self.$activeSheet) { item in
            switch item {
            case .create:
                AddSheetView()
            case .modify:
                ModifySheetView(person: self.people[indexSet], indexSet: $indexSet)
            }
        }
        .onAppear {
            guard let retrievedColor = UserDefaults.standard.value(forKey: "color") else {
                return
            }

            self.color = retrievedColor as! String
        }
        .alert(isPresented: self.$presentAlert) {
            Alert(title: Text("\(self.title)"), message: Text("\(self.msg)"), dismissButton: .default(Text("Ok")))
        }
        .actionSheet(isPresented: self.$showActionSheet) {
            ActionSheet(title: Text("Delete"), message: Text("Are you sure you want to delete \(self.people[indexSet].name)?"), buttons: [.cancel(), .destructive(Text("Delete"), action: {
                DispatchQueue.main.async {
                    self.deleteValue(at: IndexSet(integer: indexSet))
                }
            })])
        }
    }
    
    func deleteValue(at offsets: IndexSet) {
        for index in offsets {
            let deleteItem = people[index]
            self.moc.delete(deleteItem)
            
            self.indexSet = 0
            
            do {
                try self.moc.save()
            } catch {
                self.title = "Error"
                self.msg = "An error has occured while deleting \(self.people[indexSet].name). The action may or may not have worked. If not, please try again later. If this error persists please contact 'countitup@gmail.com'."
                self.presentAlert.toggle()
            }
        }
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
    }
}
