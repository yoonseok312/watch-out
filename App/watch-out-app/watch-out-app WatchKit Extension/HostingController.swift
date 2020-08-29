//
//  HostingController.swift
//  TestProject2 WatchKit Extension
//
//  Created by yoonseok312 on 2020/08/29.
//  Copyright © 2020 riiid. All rights reserved.
//


import WatchKit
import Foundation
import SwiftUI
import WatchConnectivity

class HostingController: WKHostingController<AnyView> {
  //let session = WCSession.default
  override func awake(withContext context: Any?) {
      super.awake(withContext: context)

      // Configure interface objects here.
      //session.delegate = WatchConnectivityProvider()
      //session.activate()
    WatchConnectivityProvider()
  }
  var environment = WatchEnvironment(connectivityProvider: WatchConnectivityProvider())
    override var body: AnyView {
      return AnyView(WatchView().environmentObject(environment))
    }
}

//public var title: String = "default"

//class HostingController: WKHostingController<WatchView> {
//    override var body: WatchView {
//        return WatchView()
//    }
//}
//
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

//class WatchViewModel: ObservableObject, WCSessionDelegate {
//  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//  }
//
//  func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//
//    print("received data: \(message)")
//    if let t = message["title"] as? String {
//        self.alertTitle.setText(t)
//    }
//    if let c = message["content"] as? String {
//        self.content.setText(c)
//    }
//  }
//}
