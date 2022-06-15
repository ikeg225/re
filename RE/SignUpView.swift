//
//  SignUpView.swift
//  RE
//
//  Created by Ethan Ikegami on 6/2/22.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @EnvironmentObject var dataManager: DataManager
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            TextField("", text: $name)
                .foregroundColor(.white)
                .placeholder(when: name.isEmpty) {
                    Text("Name")
                        .foregroundColor(Color(hex: "8BC3F6"))
                        .padding([.vertical], 5)
                        .font(Font.custom("Varela", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                }
                .frame(width: UIScreen.main.bounds.width - 130)
                .padding(.top, 50)
                .font(Font.custom("Varela", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 130, height: 1)
                .foregroundColor(.white)
            TextField("", text: $email)
                .foregroundColor(.white)
                .placeholder(when: email.isEmpty) {
                    Text("Email")
                        .foregroundColor(Color(hex: "8BC3F6"))
                        .padding([.vertical], 5)
                        .font(Font.custom("Varela", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                }
                .frame(width: UIScreen.main.bounds.width - 130)
                .padding(.top, 20)
                .font(Font.custom("Varela", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 130, height: 1)
                .foregroundColor(.white)
            SecureField("", text: $password)
                .foregroundColor(.white)
                .textFieldStyle(.plain)
                .placeholder(when: password.isEmpty) {
                    Text("Password")
                        .foregroundColor(Color(hex: "8BC3F6"))
                        .padding([.vertical], 5)
                        .font(Font.custom("Varela", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                }
                .padding(.top, 20)
                .frame(width: UIScreen.main.bounds.width - 130)
                .font(Font.custom("Varela", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
            Rectangle()
                .frame(width: UIScreen.main.bounds.width - 130, height: 1)
                .foregroundColor(.white)
                .padding(.bottom, 30)
            Button {
                register()
            } label: {
                Text("Sign Up")
                    .frame(width: 100, height: 40)
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white))
                    .font(Font.custom("Inter-Medium", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                    .foregroundColor(Color(hex: "1786ED"))
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                let partnerCode = Int.random(in: 10000...99999)
                dataManager.addUser(userID: result!.user.uid, partnerCode: partnerCode, name: name)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
