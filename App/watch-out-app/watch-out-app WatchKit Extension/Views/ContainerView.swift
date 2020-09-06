//
//  defaultView.swift
//  watch-out-app WatchKit Extension
//
//  Created by 이보성 on 2020/08/31.
//  Copyright © 2020 Ryan Taylor. All rights reserved.
//

import SwiftUI

struct ContainerView: View {

  @EnvironmentObject var viewModel: WatchEnvironment
  var body: some View {

    Group {
      if viewModel.word != "changed" && viewModel.isActive {
      WatchView()
    } else {
      DefaultView()
    }
    }
  }
}

struct DefaultView: View {
    @State private var animateStrokeStart = true
    @State private var animateStrokeEnd = true
    @State private var isRotating = true

  var body: some View {
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
            
         }
       }

  }
