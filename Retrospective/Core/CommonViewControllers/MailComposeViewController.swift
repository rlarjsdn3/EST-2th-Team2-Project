//
//  MailComposeViewController.swift
//  Retrospective
//
//  Created by 김건우 on 5/15/25.
//

import UIKit
import MessageUI

/// > Reference: [SwiftUI: Send email using MFMailComposeViewController](https://stackoverflow.com/questions/65743004/swiftui-send-email-using-mfmailcomposeviewcontroller)
final class MailComposeViewController: UIViewController {
    
    /// `MailComposeViewController`의 싱글톤 인스턴스입니다.
    static let shared = MailComposeViewController()

    /// 이메일 전송을 시작합니다.
    ///
    /// 사용자가 이메일을 전송할 수 있는 상태일 경우, `MFMailComposeViewController`를 통해 이메일 작성 화면을 표시합니다.
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["rlarjsdn3@naver.com"])

            UIApplication.shared.windows.last?.rootViewController?.present(mail, animated: true)
        } else {

        }
    }
}

extension MailComposeViewController: MFMailComposeViewControllerDelegate {

    func mailComposeController(
        _ controller: MFMailComposeViewController,
        didFinishWith result: MFMailComposeResult,
        error: (any Error)?
    ) {
        controller.dismiss(animated: true)
    }
}
