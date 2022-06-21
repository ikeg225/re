//
//  RecordView.swift
//  RE
//
//  Created by Ethan Ikegami on 6/10/22.
//

import SwiftUI
import Firebase

struct RecordView: View {
    var question = "What is something you're grateful for your partner?"
    
    var body: some View {
        NavigationView {
            VStack {
                Text(getDate())
                    .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                    .padding(.bottom, 0)
                HStack (spacing: 5) {
                    Text("Prompt of the Day")
                        .font(Font.custom("Inter-ExtraBold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                        .foregroundColor(Color(hex: "331832"))
                    Image("pointyred")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                }
                .padding(.vertical, 0)
                Image("man")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 150)
                Text(question)
                    .font(Font.custom("Inter-Black", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                    .padding(.vertical, 20)
                    .padding(.horizontal, 40)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(.white)
                        .shadow(color: Color.black.opacity(0.25), radius: 5, x: 0, y: 0))
                    .padding(.vertical, 20)
                NavigationLink(destination: MicView(question: question), label: {
                    Text("start record")
                        .padding(.vertical, 15)
                        .padding(.horizontal, 20)
                        .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(Color(hex: "1786ED"))
                            .shadow(color: Color.black.opacity(0.25), radius: 2, x: 3, y: 3))
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                        .foregroundColor(.white)
                })
                .padding(.vertical, 15)
                HStack (spacing: 15) {
                    Image("girl")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75)
                    Text("waiting on your partner's response...")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                }
                .frame(width: UIScreen.main.bounds.width - 100)
            }
            .offset(y: -50)
        }
    }
    
    func getDate() -> String{
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
