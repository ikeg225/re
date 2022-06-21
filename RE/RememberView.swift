//
//  RememberView.swift
//  RE
//
//  Created by Ethan Ikegami on 6/18/22.
//

import SwiftUI
import Firebase

struct RememberView: View {
    
    @State var whoseRemember = "theirs"
    @State var recordings: Array<Recording> = []
    @EnvironmentObject var dataManager: DataManager
        
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack (spacing: 5) {
                        Text("Listen Back")
                            .font(Font.custom("Inter-ExtraBold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                            .foregroundColor(Color(hex: "331832"))
                        Image("pointyred")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 15)
                    Text("Use them as podcasts when you miss hearing their voices...")
                        .font(Font.custom("Inter-Regular", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                        .padding(.bottom, 0)
                    Picker("Picker", selection: $whoseRemember) {
                        Text("theirs")
                            .tag("theirs")
                        Text("yours")
                            .tag("yours")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.top, 20)
                }
                .frame(width: UIScreen.main.bounds.width - 100)
                List {
                    ForEach(recordings, id: \.self) { recording in
                        VStack {
                            Text("\(recording.Date)".split(separator: ",")[0])
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(Font.custom("Varela", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                            HStack {
                                Image("girl")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 75)
                                VStack {
                                    Text("\(recording.Question)")
                                        .font(Font.custom("Varela", size: 15))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("\(recording.Time) minutes")
                                        .font(Font.custom("Varela", size: 10))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.top, 1)
                                }
                                .padding(.leading, 5)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white).shadow(color: Color(hex: "A5CDFF"), radius: 5, x: 10, y: 10))
                            .background(NavigationLink("", destination: PlayBackView(Question: recording.Question, Date: recording.Date, Time: recording.Time, File: recording.File)).opacity(0))
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal, 0)
                        .listRowSeparatorTint(.clear)
                    }
                }
            }
            .onAppear() {
                let user = Auth.auth().currentUser
                if let user = user {
                    dataManager.fetchRecordingsFromID(userID: user.uid) { (records) in
                        if let records = records {
                            recordings = records
                        } else {
                            recordings = []
                        }
                    }
                }
            }
            .offset(y: -25)
        }
    }
}

struct RememberView_Previews: PreviewProvider {
    static var previews: some View {
        RememberView()
    }
}
