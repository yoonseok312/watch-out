//
//  ContentView.swift
//  watch-out WatchKit Extension
//
//  Created by yoonseok312 on 2020/08/09.
//  Copyright © 2020 yoonseok. All rights reserved.
//

import SwiftUI
import AVFoundation

struct MainView: View {
  
  @ObservedObject var viewModel: MainViewModel
  
  @State private var animateStrokeStart = true
  @State private var animateStrokeEnd = true
  @State private var isRotating = true
  
  @State private var permission = UserDefaults.standard.bool(forKey: "microphonePermission")  {
         didSet {
             UserDefaults.standard.set(self.permission, forKey: "microphonePermission")
             UserDefaults.standard.synchronize()
         }
     }
     
  
  let navy = Color(red: 48.0 / 255.0, green: 66.0 / 255.0, blue: 105.0 / 255.0)
  let light = Color(red: 252.0 / 255.0, green: 240.0 / 255.0, blue: 237.0 / 255.0)
  let orange = Color(red: 242.0 / 255.0, green: 97.0 / 255.0, blue: 1.0 / 255.0, opacity: 1)
  let orangeOFF = Color(red: 240.0 / 255.0, green: 67.0 / 255.0, blue: 67.0 / 255.0, opacity: 0.5)
  let orangeON = Color(red: 240.0 / 255.0, green: 67.0 / 255.0, blue: 67.0 / 255.0, opacity: 1)
  let skyblue = Color(red: 145.0 / 255.0, green: 190.0 / 255.0, blue: 212.0 / 255.0)
  let whiteblue = Color(red: 217.0 / 255.0, green: 232.0 / 255.0, blue: 245.0 / 255.0)
  
  struct titleStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.white)
        .font(Font.custom("AppleSDGothicNeo-Bold", size: 30))
      
    }
  }
  struct titleBlackStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("AppleSDGothicNeo-Bold", size: 30))
      
    }
  }
  struct textStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.white)
        .font(Font.custom("AppleSDGothicNeo-SemiBold", size: 18))
      
    }
  }
  struct textBlackStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("AppleSDGothicNeo-SemiBold", size: 18))
      
    }
  }
  struct textSmallStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.white)
        .font(Font.custom("AppleSDGothicNeo-Light", size: 15))
    }
  }
  
  var body: some View {
    NavigationView{
      ZStack {
        navy.edgesIgnoringSafeArea(.all)
        
        VStack {
          //Spacer()
          Text("Watch Out").modifier(titleStyle())
          //          Spacer()
          if viewModel.isToggled {
            ZStack {
              Circle()
                .trim(from: animateStrokeStart ? 1/3 : 1/9, to: animateStrokeEnd ? 2/5 : 1)
                .stroke(lineWidth: 3)
                .frame(width: 200.0, height: 200.0)
                .foregroundColor(light)
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
              
              Circle()
                .frame(width: 200.0, height: 200.0)
                .foregroundColor(orangeON)
              VStack {
                Image("antenna")
                Text("ON").modifier(textStyle())
              }
            }
          }
          else {
            ZStack {
              VStack {
                Image("antenna")
                Text("OFF")
                  .modifier(textStyle())
              }
              Circle()
                .frame(width: 200.0, height: 200.0)
                .foregroundColor(orangeOFF)
              
            }
            
            
          }
          
          Toggle(isOn: $viewModel.isToggled) {
            Text("Start")
          }
          .labelsHidden()
          .frame(width: 100.0, height: 150.0)
          
          if viewModel.isToggled {
            Text("Watch Out이 위험한 소리를 듣고 있습니다!").modifier(textStyle())
            Text("버튼을 누르면 종료됩니다.").modifier(textSmallStyle())
          }
          else{
            Text("위험한 소리를 대신 들어드립니다.").modifier(textStyle())
            Text("버튼을 눌러 Watch Out을 시작하세요!").modifier(textSmallStyle())
          }
          Spacer()
          NavigationLink(destination: SettingView()) {
            Image("settings")
          }
          .accentColor(Color.white)
          
          Spacer()
        }
        if self.viewModel.popUpShow {
          
          GeometryReader{_ in
            VStack {
              //Text("팝업입니다.")
              
              VStack {
                VStack(alignment: .leading, spacing: 12) {
                  if(self.viewModel.highlightedCommand != nil){
                    Text("\(self.viewModel.highlightedCommand ?? "default text") 소리").modifier(titleBlackStyle())
                    Text("가 들렸습니다.").modifier(textBlackStyle())
                  }
                }
                Image("cone")
              }.frame(width: 250, height: 300)
                .padding()
                .background(Color.white)
                .cornerRadius(23)
              
              Text("바탕을 터치하면 화면이 사라집니다.").modifier(textSmallStyle())
            }
            
            
          }.background(
            
            Color.black.opacity(0.65)
              .edgesIgnoringSafeArea(.all)
              .onTapGesture {
                
                withAnimation{
                  
                  self.viewModel.popUpShow.toggle()
                }
            }
            
          )
        }
      }.popup(isPresented: $permission) {
        VStack(spacing: 10) {
          
          Image("microphone").padding(.top, 30)
          
          Button(action: {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
          }) {
            
            VStack {
              Spacer()
                
              Text("마이크를 사용할 수 있도록 해주세요!")
                  .foregroundColor(.white)
                  .fontWeight(.bold)
              
              Text("현재 마이크가 허용되어 있지 않습니다. 설정에서 허용 해주세요. (해당 텍스트를 클릭하시면 이동합니다)")
                  .padding()
                  .font(.system(size: 13))
                  .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))

              Spacer()
            }
          }
        }
        .frame(minWidth: 300,
               maxWidth: .infinity,
               minHeight: 300,
               maxHeight: 350)
          .background(Color(red: 255.0 / 255.0, green: 69.0 / 255.0, blue: 58.0 / 255.0))
          .cornerRadius(30.0)
      }
    } //ZStack End
  } //Navigation View End
  
}
