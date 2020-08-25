//
//  ContentView.swift
//  watch-out WatchKit Extension
//
//  Created by yoonseok312 on 2020/08/09.
//  Copyright © 2020 yoonseok. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @State private var animateStrokeStart = true
  @State private var animateStrokeEnd = true
  @State private var isRotating = true
  
  struct FontStyle: ViewModifier {
    
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.white)
        .font(Font.custom("Arial Rounded MT Bold", size: 15))
    }
  }
  
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
        NavigationLink(destination: Alert_A()){
            Text("위험 소리 탐지중...")
                  .fontWeight(.bold)
                  .modifier(FontStyle())
        }
        //            Text("Click").font(.system(size: 10, weight: .black))
        //        }
//        NavigationLink(destination: Alert(type: "fire")) {
//            Text("Click").font(.system(size: 10, weight: .black))
//        }
      
//      HStack {
//
//        NavigationLink(destination: Alert(type: "car")) {
//          Text(/*@START_MENU_TOKEN@*/"자동차"/*@END_MENU_TOKEN@*/)
//        }
//
        
    
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
