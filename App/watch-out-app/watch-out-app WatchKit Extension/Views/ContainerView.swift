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
      
      if (viewModel.toggleState == 1){
        if viewModel.word != "changed" && viewModel.isActive {
          WatchView()
        } else {
          DefaultView()
          // 안테나 돌아가는 뷰
        }
      }else{
       toggle_state()
        
      }
      
    }
  }
}

struct DefaultView: View {
  var body: some View {
    VStack {
        Text("모든 설정은")
        Text("아이폰 앱에서")
        Text("해주세요!")
    }
  }
}

struct toggle_state: View {
var body: some View {
                 VStack {
                     Image(systemName: "heart.slash").foregroundColor(.red).font(.system(size: 80)).padding(.vertical, 16)
                       Text("아이폰 연결 대기중...")
                             .fontWeight(.bold)
               }
     }

}
