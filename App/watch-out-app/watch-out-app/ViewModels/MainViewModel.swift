//
//  MainViewModel.swift
//  watch-out-app
//
//  Created by yoonseok312 on 2020/08/29.
//  Copyright © 2020 Ryan Taylor. All rights reserved.
//

import Foundation
import SwiftUI
import WatchConnectivity

class MainViewModel: ObservableObject, AudioInputManagerDelegate {
  
  @Published var isToggled = false
  
  private(set) var connectivityProvider: ConnectivityProvider
  var session: WCSession?
  private var modelDataHandler: ModelDataHandler? =
    ModelDataHandler(modelFileInfo: ConvActions.modelInfo, labelsFileInfo: ConvActions.labelsInfo)
  private var audioInputManager: AudioInputManager?
  
  // MARK: Instance Variables
  private var words: [String] = []
  private var result: Result?
  private var highlightedCommand: String?
  private var bufferSize: Int = 0
  
  init(connectivityProvider: ConnectivityProvider) {
    self.connectivityProvider = connectivityProvider
    self.startAudioRecognition()
    
  }
  
  private func startAudioRecognition() {
    
    guard let handler = modelDataHandler else {
      return
    }
    
    audioInputManager = AudioInputManager(sampleRate: handler.sampleRate)
    audioInputManager?.delegate = self
    
    guard let workingAudioInputManager = audioInputManager else {
      return
    }
    
    bufferSize = workingAudioInputManager.bufferSize
    
    workingAudioInputManager.checkPermissionsAndStartTappingMicrophone()
    //    workingAudioInputManager.start { (channelDataArray) in
    //
    //      self.runModel(onBuffer: Array(channelDataArray[0..<handler.sampleRate]))
    //      self.runModel(onBuffer: Array(channelDataArray[handler.sampleRate..<bufferSize]))
    //    }
  }
  
  private func runModel(onBuffer buffer: [Int16]) {
    
    print("🏅")
    // buffer: 2차원 배열로 변환된 음성
    result = modelDataHandler?.runModel(onBuffer: buffer)
    
    // Updates the results on the screen.
    DispatchQueue.main.async {
      guard let recognizedCommand = self.result?.recognizedCommand else {
        return
      }
      // 인식이 잘되는지 console에 출력 합니다.
      print(self.result?.recognizedCommand)
      self.highlightedCommand =  recognizedCommand.name
      
      let data: [String: Any] = ["title": self.highlightedCommand!, "content": self.highlightedCommand! + "!!!"] // Create your Dictionay as per uses
      print(data)
      self.connectivityProvider.send(message: data)
    }
  }
  
  func didOutput(channelData: [Int16]) {
    
    guard let handler = modelDataHandler else {
      return
    }
    
    //print("didOutput model");
    if self.isToggled {
      self.runModel(onBuffer: Array(channelData[0..<handler.sampleRate]))
      self.runModel(onBuffer: Array(channelData[handler.sampleRate..<bufferSize]))
    }
  }
  
  func showCameraPermissionsDeniedAlert() {
    
    //Todo: presentView 적용하여 AlertView 만들기
    
    let alertController = UIAlertController(title: "Microphone Permissions Denied", message: "Microphone permissions have been denied for this app. You can change this by going to Settings", preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
      UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(settingsAction)
    
    //presentView(alertController, animated: true)
  }
}

func presentView<V>(view: V, animated: Bool, backgroundColor: UIColor? = UIColor(named: "grey4")?.withAlphaComponent(0.4)) where V: View {
  let controller = UIHostingController(rootView: view)
  controller.view.backgroundColor = backgroundColor
  controller.modalPresentationStyle = .overFullScreen
  UIApplication.shared.windows.first?.rootViewController?.present(controller, animated: true)
}
