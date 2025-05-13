//
//  ChipLayout.swift
//  Retrospective
//
//  Created by 김건우 on 5/13/25.
//

import SwiftUI

/// 뷰를 Chill하게 배치하도록 도와주는 레이아웃입니다.
///
/// > Reference: [ChipView 구현하기](https://velog.io/@junho7108/SwiftUI-ChipView-구현하기)
struct ChipLayout: Layout {

    var verticalSpacing: CGFloat = 8
    var horizontalSpacing: CGFloat = 8

    // 레이아웃에 포함된 모든 subview가 적절히 배치되도록 전체 크기를 계산합니다.
    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        // 전체 레이아웃의 총 높이를 저장할 변수
        var totalHeight: CGFloat = 0
        // 현재 줄의 너비와 높이를 저장할 변수
        var currentRowWidth: CGFloat = 0
        var currentRowHeight: CGFloat = 0

        // 모든 자식 뷰를 순회하며 레이아웃을 계산
        for view in subviews {
            // 각 자식 뷰의 제안된 크기에 맞는 실제 크기 계산
            let viewSize = view.sizeThatFits(proposal)
            // 제안된 너비가 없는 경우 너비를 0으로 설정
            let proposalWidth = proposal.width ?? .infinity

            // 현재 줄에 뷰를 추가할 수 있는 경우 (가로 공간 초과)
            if currentRowWidth + viewSize.width > proposalWidth {
                // 현재 줄의 총 높이를 반영하고 다음 줄로 이동
                totalHeight += currentRowHeight + verticalSpacing
                // 새 줄의 초기화 (너비와 높이)
                currentRowWidth = 0
                currentRowHeight = 0
            }

            // 현재 줄에 뷰의 너비를 추가
            currentRowWidth += viewSize.width + horizontalSpacing
            // 현재 줄의 높이는 가장 높은 뷰의 높이로 유지
            currentRowHeight = max(currentRowHeight, viewSize.height)
        }

        // 마지막 줄의 높이를 총 높이에 추가
        totalHeight += currentRowHeight
        return CGSize(width: proposal.width ?? 0, height: totalHeight)
    }

    // 자식 뷰들을 지정된 영역에 수평으로 배치하고 줄바꿈을 관리합니다.
    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        // 현재 줄에서의 X 좌표와 Y 좌표를 설정 (초기 위치는 bounds의 최상단)
        var currentX: CGFloat = bounds.minX
        var currentY: CGFloat = bounds.minY
        // 현재 줄에서 가장 높은 뷰의 높이를 저장할 변수
        var maxHeightInRow: CGFloat = 0

        // 모든 자식 뷰를 순회하며 배치
        for view in subviews {
            let viewSize = view.sizeThatFits(proposal)

            // 현재 줄에서 가로 공간이 초과할 경우 줄바꿈 처리
            if currentX + viewSize.width > bounds.maxX {
                // 다음 줄로 이동 (X는 처음, Y는 다음 줄로)
                currentX = bounds.minX
                currentY += maxHeightInRow + verticalSpacing
                //
                maxHeightInRow = 0
            }

            // 자식 뷰를 현재 위치에 배치 (좌상단 기준)
            view.place(
                at: CGPoint(x: currentX, y: currentY),
                anchor: .topLeading,
                proposal: proposal
            )
            // 다음 뷰의 위치를 위해 X 좌표 이동 (현재 뷰 너비 + 수평 간격)
            currentX += viewSize.width + horizontalSpacing
            // 현재 줄의 최대 높이를 갱신 (가장 높은 뷰로 유지)
            maxHeightInRow = max(maxHeightInRow, viewSize.height)
        }
    }
}
