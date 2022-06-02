//
//  ContentView.swift
//  RE
//
//  Created by Ethan Ikegami on 6/1/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoginMode = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                Image("relogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 150)
                                
                VStack {
                    TextField("", text: $email)
                        .foregroundColor(.white)
                        .placeholder(when: email.isEmpty) {
                            Text("Email")
                                .foregroundColor(Color(hex: "8BC3F6"))
                                .bold()
                                .padding([.vertical], 5)
                        }
                        .frame(width: UIScreen.main.bounds.width - 130)
                        .padding(.top, 50)
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width - 130, height: 1)
                        .foregroundColor(.white)
                    SecureField("", text: $password)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: password.isEmpty) {
                            Text("Password")
                                .foregroundColor(Color(hex: "8BC3F6"))
                                .bold()
                                .padding([.vertical], 5)
                        }
                        .padding(.top, 20)
                        .frame(width: UIScreen.main.bounds.width - 130)
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width - 130, height: 1)
                        .foregroundColor(.white)
                    Spacer()
                }
                .background(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color(hex: "1786ED"))
                        .frame(width: UIScreen.main.bounds.width - 75, height: 400)
                        .shadow(color: Color(hex: "A5CDFF"), radius: 5, x: 10, y: 10)
                )
                .frame(width: UIScreen.main.bounds.width - 75, height: 400)
                .padding()
            }
        }
    }
}


extension Color {
    init(hex string: String) {
        var string: String = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if string.hasPrefix("#") {
            _ = string.removeFirst()
        }

        // Double the last value if incomplete hex
        if !string.count.isMultiple(of: 2), let last = string.last {
            string.append(last)
        }

        // Fix invalid values
        if string.count > 8 {
            string = String(string.prefix(8))
        }

        // Scanner creation
        let scanner = Scanner(string: string)

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        if string.count == 2 {
            let mask = 0xFF

            let g = Int(color) & mask

            let gray = Double(g) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: 1)

        } else if string.count == 4 {
            let mask = 0x00FF

            let g = Int(color >> 8) & mask
            let a = Int(color) & mask

            let gray = Double(g) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: gray, green: gray, blue: gray, opacity: alpha)

        } else if string.count == 6 {
            let mask = 0x0000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1)

        } else if string.count == 8 {
            let mask = 0x000000FF
            let r = Int(color >> 24) & mask
            let g = Int(color >> 16) & mask
            let b = Int(color >> 8) & mask
            let a = Int(color) & mask

            let red = Double(r) / 255.0
            let green = Double(g) / 255.0
            let blue = Double(b) / 255.0
            let alpha = Double(a) / 255.0

            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)

        } else {
            self.init(.sRGB, red: 1, green: 1, blue: 1, opacity: 1)
        }
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
