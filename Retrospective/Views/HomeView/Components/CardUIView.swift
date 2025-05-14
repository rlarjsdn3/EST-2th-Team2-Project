//
//  CardUIView.swift
//  Retrospective
//
//  Created by 신유섭 on 5/12/25.
//

import SwiftUI
struct CardUIView: View {

    @Environment(\.modelContext) private var modelContext

    @State var deleteAlert: Bool = false

    let diary: Diary

    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {

            HStack {
                Text(diary.title)
                    .foregroundStyle(Color.label)
                    .font(.title2)
                    .lineLimit(1)

                Spacer()

                Button {

                } label: {
                    Image(systemName: "square.and.pencil")
                        .foregroundStyle(Color.label)
                        .font(.title2)
                }

                Button {
                    deleteAlert = true

                } label: {
                    Image(systemName: "trash")
                        .foregroundStyle(Color.label)
                        .font(.title2)
                }


            }
            .padding()
            .background {
                UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20)
                    .fill(Color.appSkyBlue2)
            }

            Rectangle()
                .stroke(Color.appLightGray ,style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: [4, 10]))
                .frame(height: 1)

            HStack {
                Text(diary.contents)
                    .foregroundStyle(Color.label)
                    .lineLimit(7)
                    .padding()

                Spacer()
            }
            .background {
                UnevenRoundedRectangle(bottomLeadingRadius: 20, bottomTrailingRadius: 20)
                    .fill(Color.appSkyBlue)
            }

            // 카테고리 캡슐 갯수 제한 필요할 듯.
            HStack {
                ForEach (diary.categories) { category in
                    CategoryButton(category: category.name, categoryColor: category.color, alwaysShowCategoryHighlight: true) { }
                }
            }
            .padding(.vertical, 10)

        }
        .alert("경고창", isPresented: $deleteAlert) {
            Button(role: .destructive) {
                modelContext.delete(diary)

                    do {
                        try modelContext.save()
                    } catch {
                        print("삭제 실패: \(error)")
                    }

            } label: {
                Text("삭제하기")
            }

        } message: {
            Text("정말로 삭제하시겠습니까?")
        }
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

}
