//
//  KeyboardStatus.swift
//  Retrospective
//
//  Created by 정소이 on 5/15/25.
//

import Foundation
import SwiftUI
import Combine

protocol KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
}

extension KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },

            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
}

final class ContentViewModel: ObservableObject, KeyboardReadable {
    enum Action {
        case shouldResignKeyboard
    }

    /// 키보드가 열려있는지 여부
    @Published var isShowingKeyboard: Bool = false

    init() {
        bind()
    }

    private var cancellables = Set<AnyCancellable>()

    private func bind() {
        keyboardPublisher
            .removeDuplicates()
            .sink { [weak self] isShowing in
                guard let self else { return }
                self.isShowingKeyboard = isShowing
            }.store(in: &cancellables)
    }
}
