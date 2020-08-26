//
//  ContentView.swift
//  watch-out WatchKit Extension
//
//  Created by yoonseok312 on 2020/08/09.
//  Copyright © 2020 yoonseok. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @State private var animateStrokeStart = true
    @State private var animateStrokeEnd = true
    @State private var isRotating = true
    
    struct GradientButtonStyle: ButtonStyle {
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .foregroundColor(Color.white)
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(15.0)
        }
    }
    
    
    var body: some View {
        VStack {
            HStack() {
                Button(action: {
                    print("Button action")
                }) {
                    Text("설정")
                }.buttonStyle(GradientButtonStyle())
            }
            Spacer()
            
            ZStack {
                
                Image("microphone").overlay(
                    Circle()
                        .trim(from: animateStrokeStart ? 1/3 : 1/9, to: animateStrokeEnd ? 2/5 : 1)
                        .stroke(lineWidth: 50)
                        .frame(width: 300, height: 300)
                        .foregroundColor(Color(red: 0.0, green: 0.588, blue: 1.0))
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
                }, alignment: .center)
                
                
            }
            Spacer()
            Text("Watch-out이 듣고 있습니다...")
                .font(.system(size: 25))
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
