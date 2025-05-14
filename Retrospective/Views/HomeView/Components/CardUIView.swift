//
//  CardUIView.swift
//  Retrospective
//
//  Created by 신유섭 on 5/12/25.
//

import SwiftUI

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
                                .font(.title2)
                                .bold()
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
                        CategoryButton(category: category.name, categoryColor: category.color, alwaysShowCategoryHighlight: true) { }
                    }
                }
            }
        }
        .navigationDestination(isPresented: $isPresentedWritingView, destination: {
            WritingView(diary: diary)
        })
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
