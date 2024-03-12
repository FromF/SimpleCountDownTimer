//
//  ContentView.swift
//  TimerApp
//
//  Created by 藤治仁 on 2023/06/05.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("timer1") private var settingTimer1Value = Default.timer1
    @AppStorage("timer2") private var settingTimer2Value = Default.timer2
    @State private var timerValue1: Double = 0
    @State private var timerValue2: Double = 0
    @State private var timerHandler: Timer?
    @State private var navigatePath: [Path] = []
    
    var body: some View {
        NavigationStack(path: $navigatePath) {
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
                VStack() {
                    Spacer()
                    VStack (alignment: .trailing) {
                        Text(String(format: "%.1f", timerValue1))
                            .font(.system(size: 300, design: .monospaced))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.1)
                        if timerValue2 > 0 {
                            Text(String(format: "%.1f", timerValue2))
                                .font(.system(size: 300, design: .monospaced))
                                .foregroundColor(.white)
                                .minimumScaleFactor(0.1)
                        }
                    }
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
                            .padding()
                    }
                }
                .padding()
            }
            .onAppear {
                reset()
            }
            .onDisappear {
                if let timerHandler {
                    timerHandler.invalidate()
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        navigatePath.append(.setting)
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.white)
                    }
                }
            }
            .navigationDestination(for: Path.self) { path in
                switch path {
                case .setting:
                    SettingView()
                }
            }
        }
    }
    
    func reset() {
        timerValue1 = Double(settingTimer1Value)
        timerValue2 = Double(settingTimer2Value)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
