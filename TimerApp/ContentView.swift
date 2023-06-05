//
//  ContentView.swift
//  TimerApp
//
//  Created by 藤治仁 on 2023/06/05.
//

import SwiftUI

struct ContentView: View {
    @State var timerValue1: Double = 0
    @State var timerValue2: Double = 0
    @State var timerHandler: Timer?
    
    var body: some View {
        ZStack {
            if timerValue1 <= 0 {
                Color.red
                    .edgesIgnoringSafeArea(.all)
            } else if timerValue2 <= 0 {
                Color.blue
                    .edgesIgnoringSafeArea(.all)
            } else {
                Color.green
                    .edgesIgnoringSafeArea(.all)
            }
            VStack {
                Spacer()
                Text(String(format: "%.1f", timerValue1))
                    .font(.system(size: 100, design: .monospaced))
                    .foregroundColor(.white)
                Text(String(format: "%.1f", timerValue2))
                    .font(.system(size: 100, design: .monospaced))
                    .foregroundColor(.white)
                Spacer()
                Button {
                    if let timerHandler {
                        timerHandler.invalidate()
                    }
                    reset()
                    timerHandler = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                        if timerValue1 <= 0 {
                            timer.invalidate()
                        }
                        if timerValue1 > 0 {
                            timerValue1 -= 0.1
                        }
                        
                        if timerValue1 <= 0 {
                            timerValue1 = 0
                        }
                        
                        if timerValue2 > 0 {
                            timerValue2 -= 0.1
                        }
                        
                        if timerValue2 <= 0 {
                            timerValue2 = 0
                        }
                    }
                } label: {
                    Text("Start")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                
            }
            .padding()
        }
        .onAppear {
            reset()
        }
    }
    
    func reset() {
        timerValue1 = 180
        timerValue2 = 30
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
