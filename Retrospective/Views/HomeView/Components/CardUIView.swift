//
//  CardUIView.swift
//  Retrospective
//
//  Created by 신유섭 on 5/12/25.
//

import SwiftUI

/// 단일 `Diary` 데이터를 카드 형태로 표시하는 UI 뷰입니다.
///
/// 제목, 본문 내용, 카테고리를 표시하며,
/// 카드를 탭하면 해당 다이어리를 수정할 수 있는 `WritingView`로 이동합니다.
///
/// - 구성:
///   - 제목 영역: 상단 반원 모양 배경 + 한 줄 제한 제목 텍스트
///   - 본문 내용: 하단 반원 모양 배경 + 최대 7줄 제한 텍스트
///   - 하단: 다이어리의 카테고리들을 `ChipLayout`으로 표시
///
/// - 인터랙션:
///   - 카드를 누르면 `WritingView(diary: diary)로 Push
///
/// - Parameters:
///   - diary: 렌더링할 `Diary` 데이터 객체
struct CardUIView: View {

    @Environment(\.modelContext) private var modelContext

    @State var isPresentedWritingView: Bool = false
    @State var deleteAlert: Bool = false

    let diary: Diary

    var body: some View {
        NavigationStack {
            VStack(alignment: .trailing) {
                Button {
                    isPresentedWritingView = true
                } label: {
                    VStack(alignment: .trailing, spacing: 0) {

                        HStack {
                            Text(diary.title)
                                .foregroundStyle(Color.label)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .lineLimit(1)

                            Spacer()

                        }
                        .padding(12)
                        .background {
                            UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20)
                                .fill(Color.appSkyBlue2)
                        }

                        Divider()

                        HStack {
                            Text(diary.contents)
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(Color.label)
                                .lineLimit(7)
                                .padding(12)

                            Spacer()
                        }
                        .background {
                            UnevenRoundedRectangle(bottomLeadingRadius: 20, bottomTrailingRadius: 20)
                                .fill(Color.appSkyBlue)
                        }
                    }
                }

                ChipLayout {
                    ForEach (diary.categories) { category in
                        CategoryButton(
                            category: category.name,
                            categoryColor: category.color,
                            font: .footnote,
                            alwaysShowCategoryHighlight: true
                        ) { }
                    }
                }
            }
        }
        .navigationDestination(isPresented: $isPresentedWritingView, destination: {
            WritingView(diary: diary)
        })
        .padding(.bottom)
    }
}

#Preview {
    ScrollView {
        VStack {
            CardUIView(diary: Diary.mock.first!)
            CardUIView(diary: Diary.mock[1])
            CardUIView(diary: Diary.mock[2])
        }
    }
    .modelContainer(PersistenceManager.previewContainer)
}

#Preview {
    ScrollView {
        NavigationStack {
            VStack {
                ForEach(Diary.mock.prefix(3), id: \.id) { diary in
                    CardUIView(diary: diary)
                }
            }
        }
    }
    .modelContainer(PersistenceManager.previewContainer)
}
