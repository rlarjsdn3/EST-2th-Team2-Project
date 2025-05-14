//
//  FilterView.swift
//  Retrospective
//
//  Created by 신유섭 on 5/13/25.
//

import SwiftData
import SwiftUI

struct FilterSelectView: View {
    @Binding var filteringCategories: Set<String>
    @Binding var isPresentedFilterSelectView: Bool

    @Query var allCategories: [Category]

    @State private var tempSelection: Set<String> = []

    var categoryNames: [String] {
        allCategories.map { $0.name }
    }

    var body: some View {
        //        Form {
        VStack(spacing: 0) {
            HStack {
                Text("카테고리를 선택하세요!")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
                    .padding(.top)

                Spacer()

            }

            List {
                ForEach(allCategories, id: \.persistentModelID) { category in
                    HStack {

                        Circle()
                            .fill(category.color)
                            .frame(width: 15, height: 15)

                        Text(category.name)
                            .padding(10)

                        Spacer()

                        if tempSelection.contains(category.name) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        } else {
                            Image(systemName: "circle")
                                .foregroundColor(.gray)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        toggle(category.name)
                    }
                }

            }
            .listStyle(.plain)
            .padding(.bottom, 0)

            Button {
                filteringCategories = tempSelection
                isPresentedFilterSelectView = false
            } label: {
                Text("확인")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.background)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .cornerRadius(.appLightGray.opacity(0.33), radius: 18)
                    .padding(.vertical, 10)
            }
        }
        .frame(maxHeight: 500)
        .onAppear {
            tempSelection = filteringCategories
        }
    }

    private func toggle(_ category: String) {
        if tempSelection.contains(category) {
            tempSelection.remove(category)
        } else {
            tempSelection.insert(category)
        }
    }
}

#Preview {
    @Previewable @State var filteringCategories: Set<String> = Set([])
    @Previewable @State var isPresentedFilterSelectView: Bool = false

    FilterSelectView(filteringCategories: $filteringCategories, isPresentedFilterSelectView: $isPresentedFilterSelectView)
        .modelContainer(PersistenceManager.previewContainer)
}
