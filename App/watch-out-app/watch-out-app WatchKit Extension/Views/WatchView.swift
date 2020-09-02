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
    static let gradientStart = Color(red: 255.0 / 255, green: 60.0 / 255, blue: 0.0 / 255)
    static let gradientEnd =  Color(red: 255 / 255, green: 108 / 255, blue: 63 / 255)

    static let gradientStart_ = Color(red: 255.0 / 255, green: 168.0 / 255, blue: 0.0 / 255)
    static let gradientEnd_ =  Color(red: 255 / 255, green: 198 / 255, blue: 0 / 255)

//    var detectedWord : String = viewModel.word
      var finalIcon : String = "map"

 
var body: some View {
        VStack{
            if (viewModel.word == "default"){
                Text("아이폰에서 소리 탐지중...")
                //다른 뷰로 연결 
               }
            else{
            Spacer()
            HStack{
                // 아이콘 변경 코드
                if(viewModel.word == "yes"){
                     Image(systemName: "car").foregroundColor(.white).font(.system(size: 23)).padding(.horizontal,2)
                }else if (viewModel.word == "no"){
                     Image(systemName: "map").foregroundColor(.white).font(.system(size: 23)).padding(.horizontal,2)
                }else if (viewModel.word == "right"){
                     Image(systemName: "snow").foregroundColor(.white).font(.system(size: 23)).padding(.horizontal,2)
                }else if (viewModel.word == "left"){
                     Image(systemName: "flanme.fill").foregroundColor(.white).font(.system(size: 23)).padding(.horizontal,2)
                    }
                else{
                     Image(systemName: "heart.fill").foregroundColor(.white).font(.system(size: 23)).padding(.horizontal,2)
                }
                Text("위험 신호감지!").font(.system(size: 23, weight: .bold))
            }
            
            Spacer()
        
            HStack{
                ZStack{
              
                    if( viewModel.word == "yes"){
                       //yes 소리만 노랑색으로 박스가 바뀜
                        RoundedRectangle(cornerRadius: 23, style: .continuous)
                                           .fill(LinearGradient(
                                             gradient: .init(colors: [Self.gradientStart_, Self.gradientEnd_]),
                                             startPoint: .init(x: 0.0, y: 0.0),
                                             endPoint: .init(x: 0.5, y: 0.6)
                                           ))
                                           .frame(width: 185, height: 120)
                        
                    }else{
                        // 나머지는 주황색
                        RoundedRectangle(cornerRadius: 23, style: .continuous)
                                           .fill(LinearGradient(
                                             gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                                             startPoint: .init(x: 0.0, y: 0.0),
                                             endPoint: .init(x: 0.5, y: 0.6)
                                           ))
                                           .frame(width: 185, height: 120)
                    }
        
                    
                    VStack(alignment: .center) {
                       if( viewModel.word == "yes"){
                            Text("근처에서 소리").font(.system(size: 18, weight: .black)).padding(.vertical,7).padding(.trailing,55).foregroundColor(Color.init(red: 255.0, green: 255.0, blue: 255.0))
                        Text(viewModel.word+" 소리").font(.system(size: 37, weight: .black)).foregroundColor(Color.init(red: 0.0, green: 0.0, blue: 0.0))
                            HStack(alignment:.lastTextBaseline){
                            Text("가 들렸습니다").font(.system(size: 18, weight: .black)).padding(.vertical,7).padding(.leading,60).foregroundColor(Color.init(red: 255.0, green: 255.0, blue: 255.0))
                            }
                            
                        }else{
                            Text("근처에서 소리").font(.system(size: 18, weight: .black)).padding(.vertical,7).padding(.trailing,55).foregroundColor(Color.init(red: 0, green: 0, blue: 0))
                            Text(viewModel.word+" 소리").font(.system(size: 37, weight: .black)).foregroundColor(Color.init(red: 255.0, green: 255.0, blue: 255.0))
                            HStack(alignment:.lastTextBaseline){
                            Text("가 들렸습니다").font(.system(size: 18, weight: .black)).padding(.vertical,7).padding(.leading,60).foregroundColor(Color.init(red: 0, green: 0, blue: 0))
                            }
                        }
                     
                    }
                   
                    
                }
           
                 }
        }
    

//struct Alert_A_Previews: PreviewProvider {
//    static var previews: some View {
//        Alert_A()
//    }
//}

    }}
}
