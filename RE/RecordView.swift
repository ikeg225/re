//
//  RecordView.swift
//  RE
//
//  Created by Ethan Ikegami on 6/10/22.
//

import SwiftUI
import Firebase

struct RecordView: View {
    var body: some View {
        Button {
            signout()
        } label: {
            Text("Log Out")
                .frame(width: 100, height: 40)
                .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.white))
                .font(Font.custom("Inter-Medium", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                .foregroundColor(Color(hex: "1786ED"))
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

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
