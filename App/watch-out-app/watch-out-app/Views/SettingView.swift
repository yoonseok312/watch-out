//
//  Setting.swift
//  watch-out-app
//
//  Created by Ryan Taylor on 2020/08/27.
//  Copyright © 2020 Ryan Taylor. All rights reserved.
//

import Foundation
import SwiftUI

struct SettingView: View {
    
    var options = ["자동차", "불이야", "수지야"]
    @State var isActivate = true
    // UserDefaults.standard.value(forKey: "activate")
    
    var body: some View {
        VStack {
            Text("설정 페이지").font(.largeTitle)
            
            Image("cone")
            
            List(options, id: \.self) { option in
                Toggle(isOn: self.$isActivate) {
                    Text(option)
                }.onTapGesture {
                    print("test")
                }
            }
        }.background(Color.black)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
