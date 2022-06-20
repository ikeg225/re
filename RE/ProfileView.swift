//
//  ProfileView.swift
//  RE
//
//  Created by Ethan Ikegami on 6/18/22.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @State private var uploads = true
    @State private var alertTime = Date(timeIntervalSinceReferenceDate: -28800)
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Image("man")
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity)
                    Text("Ethan")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .title3).pointSize))
                }
                Text("&")
                    .font(Font.custom("Inter-Medium", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                    .padding(.horizontal, 10)
                VStack {
                    Image("girl")
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity)
                    Text("Uyen")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .title3).pointSize))
                }
            }
            .frame(width: UIScreen.main.bounds.width - 100)
            .padding(.top, 50)
            
            List {
                Section(header: Text("Customization").font(Font.custom("Inter-Bold", size: UIFont.preferredFont(forTextStyle: .title3).pointSize))) {
                    Text("Avatar")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                    Text("Your information")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                    Text("Pairing")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                }
                .listRowSeparatorTint(Color(hex: "1786ED"))
                
                Section(header: Text("Notification").font(Font.custom("Inter-Bold", size: UIFont.preferredFont(forTextStyle: .title3).pointSize))) {
                    DatePicker("Set Daily Alert", selection: $alertTime, displayedComponents: .hourAndMinute)
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                    Toggle("Partner’s Uploads", isOn: $uploads)
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                        .toggleStyle(SwitchToggleStyle(tint: Color(hex: "1786ED")))
                }
                .listRowSeparatorTint(Color(hex: "1786ED"))
                
                Section(header: Text("Your Data").font(Font.custom("Inter-Bold", size: UIFont.preferredFont(forTextStyle: .title3).pointSize))) {
                    Text("Favorites")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                    Text("Downloads")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                    Text("Your Code")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                }
                .listRowSeparatorTint(Color(hex: "1786ED"))
                
                Section(header: Text("Others").font(Font.custom("Inter-Bold", size: UIFont.preferredFont(forTextStyle: .title3).pointSize))) {
                    Text("Feedback")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                    Text("Terms Of Use")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                    Button {
                        signout()
                    } label: {
                        Text("Log Out")
                            .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                            .foregroundColor(.black)
                    }
                }
                .listRowSeparatorTint(Color(hex: "1786ED"))
                
                HStack (spacing: 30) {
                    Image("pointyred")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                    Image("bluestar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                    Image("pointyred")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                }
                .listRowSeparatorTint(.clear)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .listStyle(GroupedListStyle())
            .frame(width: UIScreen.main.bounds.width - 20)
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
