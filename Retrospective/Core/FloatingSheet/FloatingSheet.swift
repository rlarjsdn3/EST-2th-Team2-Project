//
//  FloatingSheet.swift
//  Retrospective
//
//  Created by 김건우 on 5/12/25.
//

import SwiftUI

struct FloatingSheet<Content>: View where Content: View {

    /// 사용자가 드래그할 때, 처음 드래그 위치와 이후 드래그 위치의 차이를 저장하는 상태 변수입니다.
    @State private var dragOffsetX: CGFloat = 0.0
    @State private var dragOffsetY: CGFloat = 0.0
    /// 드래그 동작 중 최초 드래그 정보를 저장하는 상태 변수입니다.
    @State private var previousGesture: DragGesture.Value?
    /// 현재 사용자가 드래그 중인지 여부를 나타내는 상태 변수입니다.
    @State private var isDragging: Bool = false

    /// 플로팅 시트가 표시되는 상태를 제어하는 바인딩 값입니다.
    @Binding var isPresented: Bool
    /// 시트가 닫힐 때 실행할 클로저
    private let onDismiss: (() -> Void)?
    private let content: Content

    /// 플로팅 시트의 모서리 반경을 지정하는 상수입니다.
    private let cornerRadius: Double = 24
    /// 플로팅 시트의 애니메이션 지속 시간을 지정하는 상수입니다.
    private let animationDuration: Double = 0.25


    /// 플로팅 시트를 초기화하는 생성자입니다.
    /// - Parameters:
    ///   - isPresented: 시트의 표시 여부를 제어하는 바인딩 값입니다.
    ///   - onDismiss: 시트가 닫힐 때 실행할 클로저입니다.
    ///   - content: 시트에 표시할 콘텐츠를 제공하는 클로저입니다.
    init(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        content: () -> Content
    ) {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.content = content()
    }

    var body: some View {
        ZStack {
            if isPresented {
                content
                    .frame(maxWidth: .infinity)
                    .padding()
                    .cornerRadius(.background, radius: cornerRadius)
                    .background {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .defaultShadow()
                    }
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .bottom),
                            removal: .move(edge: .bottom)
                        )
                    )
                    .padding()
                    .safeAreaPadding(.bottom)
                    .offset(x: dragOffsetX, y: dragOffsetY)
                    .scaleEffect(isDragging ? CGSize(width: 0.95, height: 0.95) : CGSize(width: 1.0, height: 1.0))
                    .animation(.smooth(duration: animationDuration), value: dragOffsetX)
                    .animation(.smooth(duration: animationDuration), value: dragOffsetY)
                    .animation(.smooth(duration: animationDuration), value: isDragging)
                    .gesture(dragGesture())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background {
            if isPresented {
                // 플로팅 시트의 백그라운드 뷰(색상)
                Color.gray.opacity(0.55)
                    .onTapGesture { dismiss() }
            }
        }
        .animation(.smooth(duration: animationDuration), value: isPresented)
        .ignoresSafeArea()
    }
}

extension FloatingSheet {

    private func dragGesture() -> some Gesture {
        DragGesture(minimumDistance: 10, coordinateSpace: .global)
            .onChanged(onChanged)
            .onEnded(onEnded)
    }

    private func onChanged(_ gesture: DragGesture.Value) {
        guard let previous = previousGesture else {
            self.previousGesture = gesture
            return
        }

        // 위로 드래그하면 offsetY가 음수(-)가 되고,
        // 아래로 드래그하면 offsetY가 양수(+)가 됩니다.
        let offsetY = gesture.location.y - previous.location.y
        let offsetX = gesture.location.x - previous.location.x

        if offsetY > 0 {
            dragOffsetY = offsetY
        } else {
            dragOffsetY = offsetY * 0.1
        }
        dragOffsetX = offsetX * 0.1
        isDragging = true
    }

    private func onEnded(_ value: DragGesture.Value) {
        if dragOffsetY > 20 {
            dismiss()
            // 뷰가 사라지는 동안 scaleEffect 효과를 유지합니다.
            // 일정 시간이 지난 후(scale 효과가 적용된 상태 유지), scaleEffect를 원래 상태로 복원합니다.
            Task.delayed(byTimeInterval: 0.25) { @MainActor in
                isDragging = false
            }
        } else {
            reset()
        }
    }

    private func reset() {
        dragOffsetX = 0
        dragOffsetY = 0
        previousGesture = nil
        isDragging = false
    }

    private func dismiss() {
        isPresented = false
        dragOffsetX = 0
        dragOffsetY = 0
        previousGesture = nil

        onDismiss?()
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = true
    FloatingSheet(isPresented: $isPresented) {
        VStack(alignment: .leading, spacing: 8) {
            Text("Marget Caplitalization")
                .font(.title2)
                .fontWeight(.bold)

            Text("As of February 3rd, US Time")
                .font(.footnote)
                .foregroundStyle(.secondary)

            VStack {
                Text("Stock Price X Shares Outstanding")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal)
            .padding(.vertical, 16)
            .cornerRadius(Color(UIColor.systemGray6), radius: 16)
            .padding(.top, 24)

            Text("Market capitalization represents the total value of a company's stock. It helps compare the size of companies in the stock market")
                .font(.footnote)
                .fontWeight(.semibold)
                .padding(.top, 24)

            Button { }
            label: {
                Text("Confirm")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .cornerRadius(.blue, radius: 14)
            .padding(.top, 12)

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 4)
        .padding(.horizontal, 4)
    }
}
