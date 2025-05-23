//
//  UIApplication+WritingView.swift
//  Retrospective
//
//  Created by 정소이 on 5/13/25.
//

import SwiftUI
import UIKit

extension UIApplication {
    /// 다이어리를 작성할 때 키보드가 올라온 상태에서 키보드 밖 화면을 터치하면 키보드가 내려가게 하는 함수입니다.
    func hideKeyboard() {
        guard let window = windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
 }

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

