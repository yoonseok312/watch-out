//
//  InterfaceController.swift
//  watch-out-app WatchKit Extension
//
//  Created by Ryan Taylor on 2020/08/21.
//  Copyright © 2020 Ryan Taylor. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity
import SwiftUI

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var alertTitle: WKInterfaceLabel!
    @IBOutlet weak var content: WKInterfaceLabel!
    @IBOutlet weak var img: WKInterfaceImage!
    
    let session = WCSession.default
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        self.img.setImage(UIImage(named: "fire"))
        
        // Configure interface objects here.
        session.delegate = self
        session.activate()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    

}

extension InterfaceController: WCSessionDelegate {
  
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
  }
  
  func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    print("received data: \(message)")
    if let t = message["title"] as? String {
        self.alertTitle.setText(t)
    }
    if let c = message["content"] as? String {
        self.content.setText(c)
    }


  }
}
