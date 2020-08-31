//
//  ContentView.swift
//  watch-out-app
//
//  Created by yoonseok312 on 2020/08/29.
//  Copyright © 2020 Ryan Taylor. All rights reserved.
//

import SwiftUI
import WatchKit
import Foundation
import SwiftUI
import WatchConnectivity

struct WatchView: View {
  
  @EnvironmentObject var viewModel: WatchEnvironment
    
    @State private var animateStrokeStart = true
    @State private var animateStrokeEnd = true
    @State private var isRotating = true
    
    static let gradientStart = Color(red: 255.0 / 255, green: 168.0 / 255, blue: 0.0 / 255)
    static let gradientEnd =  Color(red: 255 / 255, green: 198 / 255, blue: 0 / 255)
    
    struct FontStyle: ViewModifier {
      
      func body(content: Content) -> some View {
        return content
          .foregroundColor(Color.white)
          .font(Font.custom("Arial Rounded MT Bold", size: 15))
      }
    }
  
    var body: some View {
        VStack{
            if viewModel.word == "default"{
                VStack {
                 Spacer()
                    Spacer()
                    Spacer()
                  ZStack {
                      Image(systemName: "antenna.radiowaves.left.and.right").foregroundColor(.white).font(.system(size: 50))
                    Circle()
                      .trim(from: animateStrokeStart ? 1/3 : 1/9, to: animateStrokeEnd ? 2/5 : 1)
                      .stroke(lineWidth: 10)
                      .frame(width: 100, height: 100)
                      .foregroundColor(Color(red: 255, green: 0, blue:1))
                      .rotationEffect(.degrees(isRotating ? 360 : 0))
                      .onAppear() {
                        
                        withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                          self.isRotating.toggle()
                        }
                        
                        withAnimation(Animation.linear(duration: 1).delay(0.5).repeatForever(autoreverses: true)) {
                          self.animateStrokeStart.toggle()
                        }
                        
                        withAnimation(Animation.linear(duration: 1).delay(0.5).repeatForever(autoreverses: true)) {
                          self.animateStrokeEnd.toggle()
                        }
                    }
                         
                  }
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("위험 소리 탐지중...")
                        .fontWeight(.bold)
                        .modifier(FontStyle())
                
                }
            }
            else{
                VStack{
                           Spacer()
                        HStack{
                            Image(systemName: "dot.radiowaves.left.and.right").foregroundColor(.white).font(.system(size: 23)).padding(.horizontal,1)
                            Text("사용자 이름감지").font(.system(size: 23, weight: .bold))
                
                             }
                        Spacer()
                    
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 23, style: .continuous)
                                           .fill(LinearGradient(
                                             gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                                             startPoint: .init(x: 0.0, y: 0.0),
                                             endPoint: .init(x: 0.5, y: 0.6)
                                           ))
                                           .frame(width: 185, height: 120)
                                VStack(alignment: .leading) {
                                    Text("근처에서").font(.system(size: 18, weight: .black)).padding(.vertical,7).foregroundColor(Color.init(red: 255, green: 255, blue: 255))
                                    
                                    VStack(alignment:.center){
                                        Text(viewModel.word).font(.system(size: 37, weight: .black)).padding(.horizontal,10).foregroundColor(Color.init(red: 0, green: 0, blue: 0))
                                    }.onAppear {
                                      WKInterfaceDevice.current().play(.notification)
                                    }
                                    
                                    HStack(alignment:.lastTextBaseline){
                                        Text("가 들렸습니다").font(.system(size: 18, weight: .black)).padding(.vertical,7).padding(.leading,60).foregroundColor(Color.init(red: 255, green: 255, blue: 255))
                                    }
                                }
                            }
                        }
                    }
            }
        }
    }
}

struct WatchView_Previews: PreviewProvider {
  static var previews: some View {
    WatchView()
  }
}
