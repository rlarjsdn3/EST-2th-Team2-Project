//
//  UIColor+Extension.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import UIKit

extension UIColor {

    /// 라이트 모드와 다크 모드에서 다른 색상을 사용할 수 있는 UIColor 인스턴스를 생성합니다.
    /// - Parameters:
    ///   - light: 라이트 모드에서 사용할 UIColor
    ///   - dark: 다크 모드에서 사용할 UIColor
    convenience init(light: UIColor, dark: UIColor) {
        self.init { trait in
            if trait.userInterfaceStyle == .dark {
                return dark
            } else {
                return light
            }
        }
    }
}
