// Copyright 2019 The TensorFlow Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit

class ViewController: UIViewController {

  // MARK: Objects Handling Core Functionality
  private var modelDataHandler: ModelDataHandler? =
    ModelDataHandler(modelFileInfo: ConvActions.modelInfo, labelsFileInfo: ConvActions.labelsInfo)
  private var audioInputManager: AudioInputManager?

  // MARK: Instance Variables
  private var words: [String] = []
  private var result: Result?
  private var highlightedCommand: RecognizedCommand?
  private var bufferSize: Int = 0

  // MARK: View Handling Methods
  override func viewDidLoad() {
    super.viewDidLoad()

    guard let handler = modelDataHandler else {
      return
    }

    // Displays lables
    words = handler.offsetLabelsForDisplay()
    startAudioRecognition()

  }

  override var preferredStatusBarStyle : UIStatusBarStyle {
    return .lightContent
  }

  // MARK: Storyboard Segue Handlers
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
  }

  /**
   Initializes the AudioInputManager and starts recognizing on the output buffers.
   */
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
   This method runs hands off inference to the ModelDataHandler by passing the audio buffer.
   */
  private func runModel(onBuffer buffer: [Int16]) {

    // buffer: 2차원 배열로 변환된 음성
    result = modelDataHandler?.runModel(onBuffer: buffer)

    // Updates the results on the screen.
    //After(deadline: .now() + 1)
    DispatchQueue.main.async {
<<<<<<< HEAD
      print("🟥")
      self.refreshInferenceTime()
=======
>>>>>>> master
      guard let recognizedCommand = self.result?.recognizedCommand else {
        return
      }
      print(self.result?.recognizedCommand)
        
      self.highlightedCommand =  recognizedCommand
//      self.highlightResult()
    }
  }
}


extension ViewController: AudioInputManagerDelegate {

  func didOutput(channelData: [Int16]) {

    guard let handler = modelDataHandler else {
      return
    }
    
//    print("didOutput");

    self.runModel(onBuffer: Array(channelData[0..<handler.sampleRate]))
    self.runModel(onBuffer: Array(channelData[handler.sampleRate..<bufferSize]))
  }

  func showCameraPermissionsDeniedAlert() {

    let alertController = UIAlertController(title: "Microphone Permissions Denied", message: "Microphone permissions have been denied for this app. You can change this by going to Settings", preferredStyle: .alert)

    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
      UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }

    alertController.addAction(cancelAction)
    alertController.addAction(settingsAction)

    present(alertController, animated: true, completion: nil)
  }
}
