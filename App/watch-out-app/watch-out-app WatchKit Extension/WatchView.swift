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

var title: String = "default"
struct WatchView: View {
  
  @EnvironmentObject var viewModel: WatchEnvironment
  
    var body: some View {
      Text(viewModel.word)
    }
}

//struct WatchView_Previews: PreviewProvider {
//    static var previews: some View {
//        WatchView()
//    }
//}

//extension HostingController: WCSessionDelegate {
//
//  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//  }
//
//  func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//
//    print("received data: \(message)")
//    if let t = message["title"] as? String {
//        title = t
//    }
////    if let c = message["content"] as? String {
////        self.content.setText(c)
////    }
//  }
//}

//self.delegate 를 설정해줘야 하는데 self 가 아니면 weak 해서 assign 이 안되는 듯.
