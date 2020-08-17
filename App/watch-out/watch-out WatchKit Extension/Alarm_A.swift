//
//  SwiftUIView.swift
//  watch-out WatchKit Extension
//
//  Created by 이보성 on 2020/08/18.
//  Copyright © 2020 yoonseok. All rights reserved.
//

import SwiftUI

struct Alarm_A: View {
    static let gradientStart = Color(red: 29.0 / 255, green: 135.0 / 255, blue: 255.0 / 255)
    static let gradientEnd =  Color(red: 0 / 255, green: 26 / 255, blue: 185 / 255)

    var body: some View {
        VStack{
            HStack{
                Image(systemName: "car").foregroundColor(.white).font(.system(size: 23)).padding(.horizontal,2)
                Text("위험 신호감지!").font(.system(size: 23, weight: .bold))
    
                 }
            Spacer();Spacer()
        
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 23, style: .continuous)
                               .fill(LinearGradient(
                                 gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                                 startPoint: .init(x: 0.0, y: 0.0),
                                 endPoint: .init(x: 0.5, y: 0.6)
                               ))
                               .frame(width: 185, height: 140)
                    VStack(alignment: .leading) {
                        Text("근처에서").font(.system(size: 18, weight: .bold)).padding(.vertical,10)
                        Text("자동차 소리").font(.system(size: 37, weight: .black)).foregroundColor(Color.init(red: 0.0, green: 255.0, blue: 200.0))
                        HStack(alignment:.lastTextBaseline){
                            Text("가 들렸습니다").font(.system(size: 18, weight: .bold)).padding(.vertical,10).padding(.leading,60)
                        }
                    }
                   
                    
                }
           
                 }
        }
    }
}

struct Alarm_A_Previews: PreviewProvider {
    static var previews: some View {
        Alarm_A()
    }
}
