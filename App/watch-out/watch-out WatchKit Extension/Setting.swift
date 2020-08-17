//
//  Setting.swift
//  watch-out WatchKit Extension
//
//  Created by 이보성 on 2020/08/18.
//  Copyright © 2020 yoonseok. All rights reserved.
//

import SwiftUI

struct Setting: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "checkmark.circle.fill").foregroundColor(.blue).font(.system(size: 30))
                      Text("자전거 소리").font(.system(size: 23, weight: .bold))
                  }
            
            HStack{
                      Image(systemName: "checkmark.circle.fill").foregroundColor(.blue).font(.system(size: 30))
                      Text("자동차 소리").font(.system(size: 23, weight: .bold))
                  }
            HStack{
                Image(systemName: "checkmark.circle").foregroundColor(.gray).font(.system(size: 30))
                      Text("크락션 소리").font(.system(size: 23, weight: .bold))
                  }
            HStack{
                      Image(systemName: "checkmark.circle.fill").foregroundColor(.blue).font(.system(size: 30))
                      Text("사이렌 소리").font(.system(size: 23, weight: .bold))
                  }
        }
      
        
    }
}

struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
    }
}
