//
//  SettingView.swift
//  watch-out-app
//
//  Created by 공예슬 on 2020/08/27.
//  Copyright © 2020 Ryan Taylor. All rights reserved.
//

import SwiftUI

struct SettingView: View {
//    let settings: [settingList] = settingItem
    @State private var isFireToggled = true
    @State private var isCarToggled = false
    @State private var isBicycleToggled = false
    @State private var isKlaxonToggled = false
    @State private var isSirenToggled = false
    
    var body: some View {
        VStack {
//            List(settings) { item in
//                Section(header: Text("Examples")) {
//                    Toggle(isOn: $item.On){
//                        Text(item.name)
//                    }
//                }
//            }.listStyle(GroupedListStyle())
            List {
                Section(header: Text("소리 설정")) {
                    Toggle(isOn: $isFireToggled){
                        Text("불이야 소리")
                    }
                    Toggle(isOn: $isCarToggled){
                        Text("자동차 소리")
                    }
                    Toggle(isOn: $isBicycleToggled){
                        Text("자전거 소리")
                    }
                    Toggle(isOn: $isKlaxonToggled){
                        Text("경적 소리")
                    }
                    Toggle(isOn: $isSirenToggled){
                        Text("사이렌 소리")
                    }
                }
                Section(header: Text("커스텀 이름 설정")) {
                    Text("STT API 커스텀 예정")
                }
                Section(header: Text("더보기")) {
                    NavigationLink(destination: Information()){
                        VStack(alignment: .leading) {
                            Text("더 알아보기")
                            Text("Watch Out에 대해 더 알아보기")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                        }
                    }
                    
                }
            }.listStyle(GroupedListStyle())
        }.navigationBarTitle(Text("설정"), displayMode: .inline)
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
