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
  
  @EnvironmentObject var environment: WatchEnvironment
  
    var body: some View {
      Text(environment.word)
    }
}
