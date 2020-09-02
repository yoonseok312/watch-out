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

import AVFoundation
import ExytePopupView

class MainViewModel: ObservableObject, AudioInputManagerDelegate {
  
  //ConnectivityProvider 에서 접근 가능하도록 environment object 로 변수 선언
  @Published var isToggled = false
  @Published var popUpShow = false
  
  private(set) var connectivityProvider: ConnectivityProvider
  var session: WCSession?
  private var modelDataHandler: ModelDataHandler? =
    ModelDataHandler(modelFileInfo: ConvActions.modelInfo, labelsFileInfo: ConvActions.labelsInfo)
  private var audioInputManager: AudioInputManager?
  
  // MARK: Instance Variables
  private var words: [String] = []
  private var result: Result?
  var highlightedCommand: String?
  private var bufferSize: Int = 0
  
  init(connectivityProvider: ConnectivityProvider) {

    UserDefaults.standard.set(false, forKey: "microphonePermission")
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
  
  /**
   모델로부터 결과를 받아 알림 설정을 검사한 후 해당 알림이 꺼져있다면 false, 아니면 true를 반환하는 메소드 입니다.
   
   모델로 부터 받은 결과(단어)를 parameter(result)로 받아서 사용자의 iOS에 저장되어있는 설정 값들을 비교 합니다.
   
   - parameters:
   - result: String type의 단어
   - returns: 해당 알람이 off라면 false, 아니면 true
   
   - Author:
   김창윤
   */
  private func checkSettingOptions(result: String) -> Bool {
    
    if result == "fire" {
      return !UserDefaults.standard.bool(forKey: "fire")
    }
    else if result == "car" {
      return !UserDefaults.standard.bool(forKey: "car")
    }
    else if result == "yes" {
      return !UserDefaults.standard.bool(forKey: "yes")
    }
    else if result == "no" {
      return !UserDefaults.standard.bool(forKey: "no")
    }
    return !UserDefaults.standard.bool(forKey: "right")
  }
  
  private func popUpFasleinSecond() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
      self.popUpShow = false
    }
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
      
      // Watch로 메세지를 보내기전 알림 설정을 확인 합니다.
      if !self.checkSettingOptions(result: recognizedCommand.name) {
        
        print("\t🔕 BLOCKED: \(recognizedCommand.name)")
        return
      }
      print("🔈 Listen: \(recognizedCommand.name)")
      // 인식된 단어를 highlightedCommand에 저장합니다.
      self.highlightedCommand =  recognizedCommand.name
      let data: [String: Any] = ["title": self.highlightedCommand!, "content": self.highlightedCommand! + "!!!"]
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
    
    switch AVAudioSession.sharedInstance().recordPermission {
    case AVAudioSessionRecordPermission.granted:
      print("Permission granted")
    case AVAudioSessionRecordPermission.denied:
      print("Pemission denied")
      UserDefaults.standard.set(true, forKey: "microphonePermission")
      UserDefaults.standard.synchronize()
      
    case AVAudioSessionRecordPermission.undetermined:
      print("Request permission here")
      AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
        // Handle granted
      })
    @unknown default:
      UserDefaults.standard.set(false, forKey: "microphonePermission")
    }
  }
}
