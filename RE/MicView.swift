//
//  MicView.swift
//  RE
//
//  Created by Ethan Ikegami on 6/20/22.
//

import SwiftUI

struct MicView: View {
    
    @State private var recording = false
    @State private var play = false
    @State private var time = 0
    @State private var time_minutes = "00"
    @State private var time_seconds = "00"
    @State private var time_milliseconds = "00"
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var question: String
    
    var body: some View {
        VStack {
            Text(question)
                .font(Font.custom("Inter-Black", size: UIFont.preferredFont(forTextStyle: .title2).pointSize))
                .padding(.vertical, 40)
                .padding(.horizontal, 40)
                .frame(width: UIScreen.main.bounds.width - 100)
                .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(.white)
                    .shadow(color: Color.black.opacity(0.25), radius: 5, x: 0, y: 0))
                .padding(.vertical, 20)
            Text("RECORDING")
                .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 150)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.black, lineWidth: 3)
                )
            HStack {
                Image("backforward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .offset(x: -50)
                Text("\(time_minutes):\(time_seconds):\(time_milliseconds)")
                    .font(Font.custom("RobotoMono-Bold", size: UIFont.preferredFont(forTextStyle: .title1).pointSize))
                    .onReceive(timer) { _ in
                        if self.recording {
                            self.time += 1
                            time_minutes = String(format: "%02d", (time / (100 * 60)) % 60)
                            time_seconds = String(format: "%02d", (time / 100) % 60)
                            time_milliseconds = String(format: "%02d", time % 100)
                        }
                    }
                    .onAppear() {
                        self.stopTimer()
                    }
                Image("backforward")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .offset(x: 50)
            }
            .frame(width: UIScreen.main.bounds.width - 100)
            .padding(.top, 20)
            if play {
                Button {
                    play = false
                } label: {
                    Image("pause")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 50)
                        .padding(.bottom, 30)
                }
            } else {
                Button {
                    play = true
                } label: {
                    Image("play")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 50)
                        .padding(.bottom, 30)
                }
            }
            HStack(spacing: 0) {
                if recording {
                    Button {
                        recording = false
                        self.stopTimer()
                    } label: {
                        Text("Pause")
                            .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .fill(Color(hex: "1786ED"))
                                .frame(width: 130, height: 50)
                                .shadow(color: Color.black.opacity(0.25), radius: 2, x: 3, y: 3))
                            .font(Font.custom("Inter-Bold", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .offset(x: 25)
                    }
                } else {
                    Button {
                        recording = true
                        self.startTimer()
                    } label: {
                        Text("Start")
                            .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
                                .fill(Color(hex: "1786ED"))
                                .frame(width: 130, height: 50)
                                .shadow(color: Color.black.opacity(0.25), radius: 2, x: 3, y: 3))
                            .font(Font.custom("Inter-Bold", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .offset(x: 20)
                    }
                }
                Button {
                    // Do something when they finish their recording
                } label: {
                    Text("Done")
                        .font(Font.custom("Inter-Bold", size: UIFont.preferredFont(forTextStyle: .body).pointSize))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 50)
                        .foregroundColor(.black)
                }
            }
        }
        .offset(y: -50)
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }
}

struct MicView_Previews: PreviewProvider {
    static var previews: some View {
        MicView(question: "This is a test question?")
    }
}
