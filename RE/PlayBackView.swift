//
//  PlayBackView.swift
//  RE
//
//  Created by Ethan Ikegami on 6/21/22.
//

import SwiftUI

struct PlayBackView: View {
    
    var Question: String
    var Date: String
    var Time: String
    var File: String
    
    var body: some View {
        VStack {
            Image("girl")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width - 150)
            Text(Date)
                .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                .padding(.top, 15)
            Text(Question)
                .font(Font.custom("Inter-Black", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                .padding(.vertical, 40)
                .padding(.horizontal, 40)
                .frame(width: UIScreen.main.bounds.width - 100)
                .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(.white)
                    .shadow(color: Color.black.opacity(0.25), radius: 5, x: 0, y: 0))
        }
        .offset(y: -50)
    }
}

struct PlayBackView_Previews: PreviewProvider {
    static var previews: some View {
        PlayBackView(Question: "Test question here?", Date: "June 12", Time: "3:45", File: "somefile.mp3")
    }
}
