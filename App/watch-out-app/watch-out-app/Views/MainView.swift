//
//  ContentView.swift
//  watch-out WatchKit Extension
//
//  Created by yoonseok312 on 2020/08/09.
//  Copyright © 2020 yoonseok. All rights reserved.
//
// 2019년 6월에 나온 친구...
import SwiftUI
// Pods - 의존성 관리 해주는 친구
// SwiftPackage Manager
struct MainView: View {
  
  @ObservedObject var viewModel: MainViewModel
    
    @State private var animateStrokeStart = true
    @State private var animateStrokeEnd = true
    @State private var isRotating = true
    
    let navy = Color(red: 48.0 / 255.0, green: 66.0 / 255.0, blue: 105.0 / 255.0)
    let light = Color(red: 252.0 / 255.0, green: 240.0 / 255.0, blue: 237.0 / 255.0)
    let orange = Color(red: 242.0 / 255.0, green: 97.0 / 255.0, blue: 1.0 / 255.0, opacity: 1)
    let orangeOFF = Color(red: 240.0 / 255.0, green: 67.0 / 255.0, blue: 67.0 / 255.0, opacity: 0.5)
    let orangeON = Color(red: 240.0 / 255.0, green: 67.0 / 255.0, blue: 67.0 / 255.0, opacity: 1)
    let skyblue = Color(red: 145.0 / 255.0, green: 190.0 / 255.0, blue: 212.0 / 255.0)
    let whiteblue = Color(red: 217.0 / 255.0, green: 232.0 / 255.0, blue: 245.0 / 255.0)
    
    static let gradientStart = Color(red: 255.0 / 255, green: 60.0 / 255, blue: 0.0 / 255)
    static let gradientEnd =  Color(red: 255 / 255, green: 108 / 255, blue: 63 / 255)
    
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
                Text("Watch Out").modifier(titleStyle())
                Spacer()
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
//                            RoundedRectangle(cornerRadius: 23, style: .continuous)
//                            .fill(LinearGradient(
//                              gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
//                              startPoint: .init(x: 0.0, y: 0.0),
//                              endPoint: .init(x: 0.5, y: 0.6)
//                            ))
//                            .frame(width: 185, height: 120)
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
            
        } //ZStack End
        } //Navigation View End
            
    }
}
