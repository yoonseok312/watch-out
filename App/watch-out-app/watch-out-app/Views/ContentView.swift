//
//  ContentView.swift
//  watch-out-app
//
//  Created by yoonseok312 on 2020/09/13.
//  Copyright © 2020 Ryan Taylor. All rights reserved.
//

import SwiftUI
import MessageUI
struct ContentView: View {

    private let mailComposeDelegate = MailComposerDelegate()

    private let messageComposeDelegate = MessageComposerDelegate()

    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                self.presentMailCompose()
            }) {
                Text("email")
            }

            Spacer()

           Button(action: {
               self.presentMessageCompose()
           }) {
               Text("Message")
           }
            Spacer()
        }
    }
}


extension ContentView {

    private class MailComposerDelegate: NSObject, MFMailComposeViewControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {

            controller.dismiss(animated: true)
        }
    }
    private func presentMailCompose() {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }
        let vc = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = mailComposeDelegate

        vc?.present(composeVC, animated: true)
    }
}

extension ContentView {

    private class MessageComposerDelegate: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            // Customize here
            controller.dismiss(animated: true)
        }
    }
    private func presentMessageCompose() {
        guard MFMessageComposeViewController.canSendText() else {
            return
        }
        let vc = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = messageComposeDelegate

        vc?.present(composeVC, animated: true)
    }
}
