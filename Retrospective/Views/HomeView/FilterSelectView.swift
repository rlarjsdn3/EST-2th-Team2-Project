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

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("카테고리를 선택하세요!")
                    .font(.title2)
                    .bold()
                    .padding(.horizontal)
                    .padding(.top)

                Spacer()

            }
            .padding(.bottom, 20)

            List {
                ForEach(Array(allCategories.sorted { $0.name < $1.name }.enumerated()), id: \.element.persistentModelID) {
                    index, category in
                    VStack(spacing: 0) {
                        HStack {
                            Circle()
                                .fill(category.color)
                                .frame(width: 15, height: 15)

                            Text(category.name)

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

                        if index != allCategories.count - 1 {
                            Rectangle()
                                .fill(Color.appLightGray)
                                .frame(height: 1)
                                .padding(.vertical, 20)
                        } else {
                            Rectangle()
                                .fill(.clear)
                                .frame(height: 1)
                                .padding(.vertical, 20)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                .listRowSeparator(.hidden)
                .padding(.horizontal, 10)
            }
            .listStyle(.plain)

            RoundedRectButton(title: "확인") {
                filteringCategories = tempSelection
                isPresentedFilterSelectView = false
            }
            .padding(.top, 15)
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
