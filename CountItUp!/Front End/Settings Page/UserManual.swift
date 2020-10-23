//
//  UserManual.swift
//  CountItUp!
//
//  Created by Bhuvan Gundela on 10/23/20.
//

import SwiftUI

struct UserManual: View {
    @Binding var color: String
    
    var body: some View {
        VStack {
            Text("User Manual")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding()
                .foregroundColor(Color("\(color)"))
            
            ScrollView {
                Text("Hello, thank you for using Count It Up! Welcome to the easiest way of tracking points. Count It Up can be used in households, schools, tournaments, and offices. There are 4 tabs to navigate the app: Home, Group, History, and Settings. In Home, it is just to quickly update someone's points and get on with your day. Use the plus and minus to add or subtract and the right and left arrows to switch persons. The Group page is where you can create, update, and delete memebers. Next is the History page. This tab keeps track of your updates and creations. You may delete all history if you wish. That will reset all people's history to 'No History'. Last but not least, we have the Settings page. Here you can change the increment in which you add or subtract by, read the user manual, decide if you want to reset each month and change the man color of your app. The increment will be used on the home page, where you add or subtract points. The 'Reset Every Month Option' will be used to reset your points to 0 after every month. Turn it on if you want this functionality. The Main Color is the theme of your app. They are all different colors. If any errors pop up or if you have any questions email the helpline at 'countitup@gmail.com'. Thank you, and I hope your experience using this app will be pleasant. Bye!")
                    .padding()
                    .font(.headline)
                    .foregroundColor(Color("\(color)"))
            }
            
            Spacer()
        }
    }
}

struct UserManual_Previews: PreviewProvider {
    static var previews: some View {
        UserManual(color: .constant("Blue"))
    }
}
