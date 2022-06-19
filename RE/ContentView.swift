//
//  ContentView.swift
//  RE
//
//  Created by Ethan Ikegami on 6/1/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State private var isUserLoggedIn = false
    @State private var showPartnerCode = false
    @State private var partnerCode = 0
    
    @StateObject var otpModel: OTPViewModel = .init()
    @FocusState var activeField: OTPField?
    
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        if isUserLoggedIn {
            InAppView()
            .onAppear() {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                    } else {
                        isUserLoggedIn = false
                    }
                }
            }
        } else {
            if showPartnerCode {
                ZStack {
                    VStack {
                        Text("Your Code")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                        Text(verbatim: "\(partnerCode)")
                        .font(Font.custom("Inter-Bold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                        .padding(.top, 2)
                        Text("or")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                        Text("Enter Your Partner's Code")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                        OTPField()
                            .padding()
                            .onChange(of: otpModel.otpFields) { newValue in
                                OTPCondition(value: newValue)
                            }
                        Button {
                            showPartnerCode = false
                            isUserLoggedIn = true
                        } label: {
                            Text("Next")
                        }
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Image("codestar")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150)
                                .padding(.trailing, 0)
                                .padding(.bottom, 0)
                          }
                    }
                }
            }
            else {
                NavigationView {
                    LoggedView()
                    .onAppear() {
                        Auth.auth().addStateDidChangeListener { auth, user in
                            if user != nil {
                                let creation = user!.metadata.creationDate
                                let signin = user!.metadata.lastSignInDate
                                if creation == signin {
                                    showPartnerCode = true
                                    dataManager.fetchCodeFromID(userID: user!.uid) { (id) in
                                        if let id = id {
                                            partnerCode = id
                                        } else {
                                            partnerCode = 0
                                        }
                                    }
                                } else {
                                    isUserLoggedIn = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func OTPCondition(value: [String]) {
        for index in 0..<4 {
            if value[index].count == 1 && activeStateForIndex(index: index) == activeField {
                activeField = activeStateForIndex(index: index + 1)
            }
        }
        
        for index in 1...4 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = activeStateForIndex(index: index - 1)
            }
        }
        
        for index in 0..<5 {
            if value[index].count > 1 {
                otpModel.otpFields[index] = String(value[index].last!)
            }
        }
    }
    
    @ViewBuilder
    func OTPField()->some View {
        HStack(spacing: 20){
            ForEach(0..<5,id: \.self){index in
                ZStack() {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(hex: "EA566E"))
                        .frame(width: 50, height: 50)
                        .shadow(color: Color(hex: "FFB2C2"), radius: 2, x: 5, y: 5)
                    
                    TextField("", text: $otpModel.otpFields[index])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .accentColor(.clear)
                        .focused($activeField, equals: activeStateForIndex(index: index))
                }
                .frame(width: 40)
            }
        }
    }
    
    func activeStateForIndex(index: Int)->OTPField {
        switch index {
        case 0: return .field1
        case 1: return .field2
        case 2: return .field3
        case 3: return .field4
        default: return .field5
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
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
            ContentView()
                .previewInterfaceOrientation(.portrait)
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}

enum OTPField {
    case field1
    case field2
    case field3
    case field4
    case field5
}
