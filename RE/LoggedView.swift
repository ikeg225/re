//
//  LoggedView.swift
//  RE
//
//  Created by Ethan Ikegami on 6/2/22.
//

import SwiftUI

struct LoggedView: View {
    
    @State private var isLoginMode = true
    
    var body: some View {
        ZStack {
            ScrollView {
                Image("relogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 150)
                
                ZStack (alignment: .bottomTrailing) {
                    VStack {
                        if isLoginMode {
                            LogInView()
                            Text("Don't have an account?")
                                .padding(.bottom, 2)
                                .padding(.top, 15)
                                .foregroundColor(.white)
                                .font(Font.custom("Inter-Medium", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                            Button {
                                self.isLoginMode = false
                            } label: {
                                Text("Sign Up")
                                    .underline()
                                    .foregroundColor(.white)
                                    .font(Font.custom("Inter-Medium", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                            }
                            Spacer()
                        } else {
                            SignUpView()
                            Text("Have an account?")
                                .padding(.bottom, 2)
                                .padding(.top, 15)
                                .foregroundColor(.white)
                                .font(Font.custom("Inter-Medium", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                            Button {
                                self.isLoginMode = true
                            } label: {
                                Text("Log In")
                                    .underline()
                                    .foregroundColor(.white)
                                    .font(Font.custom("Inter-Medium", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                            }
                            Spacer()
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color(hex: "1786ED"))
                            .frame(width: UIScreen.main.bounds.width - 75, height: isLoginMode ? 400 : 450)
                            .shadow(color: Color(hex: "A5CDFF"), radius: 5, x: 10, y: 10)
                    )
                    .frame(width: UIScreen.main.bounds.width - 75, height: isLoginMode ? 400 : 450)
                    .padding()
                    Image("redstar")
                        .frame(width: 30, height: 30)
                        .padding()
                }
                .padding()
            }
        }
    }
}

struct LoggedView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedView()
    }
}
