//
//  defaultView.swift
//  watch-out-app WatchKit Extension
//
//  Created by 이보성 on 2020/08/31.
//  Copyright © 2020 Ryan Taylor. All rights reserved.
//

import SwiftUI

struct defaultView: View {
<<<<<<< HEAD
    @EnvironmentObject var viewModel: WatchEnvironment
    
    var body: some View {
        VStack{
            // 디폴트 뷰로 구현
            Text("아이폰에서\nwatch-out 앱을\n켜주셨나요?")
                .fontWeight(.semibold).multilineTextAlignment(.center)
            Text("\n그렇다면,\n아이폰에서 소리 탐지 중입니다.")
            .fontWeight(.semibold).multilineTextAlignment(.center)
                
            // viewModel.word에 텍스트가 들어오면 -> WatchView
            if (viewModel.isActive == true){
                //다른 뷰로 연결
                WatchView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)    }
=======
  @EnvironmentObject var viewModel: WatchEnvironment
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    // 디폴트 뷰로 구현
    // viewModel.word에 텍스트가 들어오면 -> WatchView
  }
>>>>>>> master
}


struct defaultView_Previews: PreviewProvider {
  static var previews: some View {
    defaultView()
  }
}
