//
//  SignUpView.swift
//  RE
//
//  Created by Ethan Ikegami on 6/2/22.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var avatar: String = "blue"
    
    var body: some View {
        VStack {
            TextField("", text: $email)
                .foregroundColor(.white)
                .placeholder(when: email.isEmpty) {
                    Text("Email")
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
            HStack {
                Button {
                    self.avatar = "blue"
                } label: {
                    
                    Image("blueavatar")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .opacity((avatar == "blue") ? 1 : 0.5)
                }
                Button {
                    self.avatar = "pink"
                } label: {
                    Image("pinkavatar")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .opacity((avatar == "pink") ? 1 : 0.5)
                }
            }
            .padding(.vertical, 20)
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
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
