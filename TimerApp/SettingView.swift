//
//  SettingView.swift
//  TimerApp
//
//  Created by 藤治仁 on 2024/03/12.
//

import SwiftUI

struct SettingView: View {
    @State private var isTimer1Set = false
    @State private var isTimer2Set = false
    @AppStorage("timer1") private var settingTimer1Value = Default.timer1
    @AppStorage("timer2") private var settingTimer2Value = Default.timer2
    var seconds: [Int] {
        var seconds: [Int] = []
        for second in stride(from: 0, to: 181, by: 10) {
            if second != 0 {
                seconds.append(second)
            }
        }
        return seconds
    }
    
    var body: some View {
        List {
            Section {
                Button {
                    withAnimation {
                        isTimer1Set.toggle()
                        isTimer2Set = false
                    }
                } label: {
                    HStack {
                        Text("第１タイマー")
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(settingTimer1Value)")
                            .foregroundColor(isTimer1Set ? .blue : .secondary)
                    }
                }
                if isTimer1Set {
                    Picker("", selection: $settingTimer1Value) {
                        ForEach(0..<Int(seconds.count), id: \.self) { index in
                            Text("\(seconds[index])")
                                .tag(seconds[index])
                        }
                    }
                    .pickerStyle(.wheel)
                }
                Button {
                    withAnimation {
                        isTimer1Set = false
                        isTimer2Set.toggle()
                    }
                } label: {
                    HStack {
                        Text("第２タイマー")
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(settingTimer2Value)")
                            .foregroundColor(isTimer2Set ? .blue : .secondary)
                    }
                }
                if isTimer2Set {
                    Picker("", selection: $settingTimer2Value) {
                        ForEach(0..<Int(seconds.count), id: \.self) { index in
                            Text("\(seconds[index])")
                                .tag(seconds[index])
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
        }
    }
}

#Preview {
    SettingView()
}
