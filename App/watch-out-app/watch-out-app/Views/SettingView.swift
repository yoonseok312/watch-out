//
//  SettingView.swift
//  watch-out-app
//
//  Created by 공예슬 on 2020/08/27.
//  Copyright © 2020 Ryan Taylor. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    @State private var isToggled = false
    let settingItemList = ["불이야 소리", "자전거 소리", "자동차 소리", "크락션 소리", "사이렌 소리"]
    
    var body: some View {
        List(settingItemList, id: \.self) { settingItem in
            //Toggle(isOn: \.self) {
                Text(settingItem)
            //}
        }.navigationBarTitle(Text("설정"), displayMode: .inline)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
