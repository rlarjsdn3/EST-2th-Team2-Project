//
//  WritingViewModel.swift
//  Retrospective
//
//  Created by 정소이 on 5/15/25.
//

import SwiftUI
import Combine

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
