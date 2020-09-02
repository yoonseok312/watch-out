//
//  WatchViewModel.swift
//  watch-out-app
//
//  Created by yoonseok312 on 2020/08/29.
//  Copyright © 2020 Ryan Taylor. All rights reserved.
//

import Foundation
import SwiftUI
import WatchConnectivity

class WatchEnvironment: ObservableObject {
  
  @Published var word: String = "default"
    @Published var isActive = false
    
  private(set) var connectivityProvider: WatchConnectivityProvider
  
  init(connectivityProvider: WatchConnectivityProvider) {
    self.connectivityProvider = connectivityProvider
    
  }
  
  func changeWord(word: String) {
    self.word = word
  }
<<<<<<< HEAD

    func activate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // your code here
            self.isActive = true
        }
    }

=======
  
  
>>>>>>> master
}
