//
//  BaseAlertView.swift
//  watch-out-app
//
//  Created by yoonseok312 on 2020/09/02.
//  Copyright © 2020 Ryan Taylor. All rights reserved.
//

import SwiftUI
import Combine

struct BaseAlertView: View {
  
  enum AlertType {
    case okCancel
    case `default`
  }
  
  let title: String
  let description: String
  let button: (title: String, action: () -> Void)
  let secondButton: (title: String, action: () -> Void)?

  
  @State var scale: CGFloat = 1
  
  init(
    title: String = "",
    description: String = "",
    button: (title: String, action: () -> Void),
    secondButton: (title: String, action: () -> Void)? = nil) {
    self.title = title
    self.description = description
    self.button = button
    self.secondButton = secondButton
  }
  
  var body: some View {
    Group {
      VStack(spacing: 0) {
        Text(title)
          .font(Font.custom("SpoqaHanSans-Regular", size: 18))
          .frame(height: 34)
          .padding(.top, 24)
        Spacer()
          .frame(height: 8)
        
        Text(description)
          .font(Font.custom("SpoqaHanSans-Regular", size: 18))
          .frame(height: 84)
          .multilineTextAlignment(.center)
          .padding([.leading, .trailing], 20)
        
        Spacer()
        
        Rectangle()
          .fill(Color.white)
          .frame(height: 1)
        buttonView()
          .frame(height: 54)
      }
      .frame(width: 316, height: 205)
    }
    .background(Color.white)
    .cornerRadius(4)
    .scaleEffect(scale)
    .onAppear {
      let animation = Animation.easeOut(duration: 0.085)
      return withAnimation(animation) {
        self.scale = 0.9
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.085) {
          withAnimation(animation) {
            self.scale = 1
          }
        }
      }
      
    }
  }
  
  private func buttonView() -> AnyView {
    if let secondButton = secondButton {
      let view =
        HStack(spacing: 0) {
          Button(action: button.action) {
            Text(button.title)
            .font(Font.custom("SpoqaHanSans-Regular", size: 18))
              .frame(width: 157, height: 54)
          }
          .frame(maxWidth: .infinity)
          Rectangle()
            .fill(Color.white)
            .frame(width: 1)
          Button(action: secondButton.action) {
            Text(secondButton.title)
              .font(Font.custom("SpoqaHanSans-Regular", size: 18))
              .frame(width: 157, height: 54)
          }
          .frame(maxWidth: .infinity)
      }
      return AnyView(view)
    }
    let view =
      Button(action: button.action) {
        Text(button.title)
          .font(Font.custom("SpoqaHanSans-Regular", size: 18))
          .frame(width: 316, height: 54)
    }
    return AnyView(view)
  }
}

struct BaseAlertView_Previews: PreviewProvider {
  static var previews: some View {
    BaseAlertView(
      title: "Microphone Permissions Denied",
      description: "Microphone permissions have been denied for this app. You can change this by going to Settings",
      button: (title: "Settings", action: {
        UIAlertAction(title: "Settings", style: .default) { (action) in
          UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
        
      })
    )
  }
}
