
//  SettingView.swift
//  watch-out-app
//
//  Created by Ryan Taylor on 2020/08/27.
//  Copyright © 2020 Ryan Taylor. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    
    @State private var fireActivate = UserDefaults.standard.bool(forKey: "fire")
    @State private var carActivate = UserDefaults.standard.bool(forKey: "car")
    @State private var watchoutActivate = UserDefaults.standard.bool(forKey: "watchout")
    
    let appleGray3 = Color(red: 199.0 / 255.0, green: 199.0 / 255.0, blue: 204.0 / 255.0)
    
    var body : some View {
        
        VStack(spacing: 15) {
            
            VStack(spacing: 15) {
                
                Form {
                    Section(header: Text("알림 설정"))  {
                        
                        OptionView(image: "car", name: "자동차 소리")
                        OptionView(image: "fire", name: "불이야 소리")
                        OptionView(image: "cone", name: "조심해 소리")
                        OptionView(image: "cone", name: "또 뭐가 있을까 소리")
                        OptionView(image: "cone", name: "뭘 넣지 소리")
                    }
                    
                    Section(header: Text("추가 기능"))  {
                        OptionView(image: "settings_other", name: "외부 API 사용")
                    }
                }
            }
            
            Spacer()
        }.navigationBarTitle("설정")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

struct OptionView: View {
    
    @State private var activate: Bool = false
    
    var image = ""
    var name = ""
    
    init(image: String?, name: String?) {
        self.image = image ?? ""
        self.name = name ?? ""
        self.activate = UserDefaults.standard.bool(forKey: image!)
    }
    
    var body : some View {
        
        HStack {
            
            Image(image).renderingMode(.original).resizable().frame(width: 40, height: 40)
            Toggle(isOn: .constant(true)) {
                Text(name)
            }
            Spacer(minLength: 15)
            
        }.padding().foregroundColor(Color.black.opacity(0.5))
    }
}
