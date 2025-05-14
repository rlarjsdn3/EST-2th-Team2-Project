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
                ForEach(allCategories.sorted { $0.name < $1.name }, id: \.persistentModelID) { category in
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

            RoundedRectButton(title: "확인") {
                filteringCategories = tempSelection
                isPresentedFilterSelectView = false
            }
            .padding(.vertical)
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
