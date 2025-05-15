
//
//  EditCategoryView.swift
//  Retrospective
//
//  Created by juks86 on 5/12/25.
//

import SwiftUI
import SwiftData

struct EditCategoryView: View {
    var placeholder: String = ""

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Bindable var category: Category
    @State private var newCategoryName: String = ""
    @State private var editedName: String
    @State private var r: Double
    @State private var g: Double
    @State private var b: Double
    @State private var dragging = false
    @State private var showAlert = false
    @State private var showingMinimumCategoryAlert = false
    @State private var showEmptyNameAlert = false
    init(category: Category) {
        self.category = category
        _editedName = State(initialValue: category.name)

        let components = category.color.rgbComponents()
        _r = State(initialValue: components.red)
        _g = State(initialValue: components.green)
        _b = State(initialValue: components.blue)
    }

    var editedColor: Color {
        Color(red: r / 255, green: g / 255, blue: b / 255)
    }

    var body: some View {
        RetrospectiveNavigationStack {
            ZStack {
                Color.appLightPeach
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {
                        VStack {
                            HStack {
                                TextField(placeholder, text: $editedName)
                                    .autocapitalization(.none)
                                    .onChange(of: editedName) { newValue in
                                        if newValue.count > 15 {
                                            editedName = String(newValue.prefix(15))
                                        }
                                    }
                                    .padding()
                                    .frame(height: 45)
                                    .background(
                                        RoundedRectangle(cornerRadius: 18)
                                            .fill(Color.appLightGray.opacity(0.33))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 18)
                                            .stroke(Color.appLightGray.opacity(0.33), lineWidth: 1)
                                    )
                                    .padding()
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 80, alignment: .top)
                        .padding(.bottom, 20)
                        .background(Color.appLightPeach)

                        VStack {
                            Circle()
                                .fill(editedColor)
                                .frame(width: 200, height: 200)

                            Group {
                                sliderView(value: $r, label: "Red", color: .red)
                                sliderView(value: $g, label: "Green", color: .green)
                                sliderView(value: $b, label: "Blue", color: .blue)
                            }
                            .padding()

                            Spacer(minLength: 100)
                        }
                        .background(Color.appLightPeach)
                        .padding(.vertical,0)
                    }
                }
                .scrollDismissesKeyboard(.interactively)
                .scrollDisabled(true)
            }
            .retrospectiveNavigationTitle("카테고리 편집")
            .retrospectiveNavigationBarColor(.appLightPeach)
            .retrospectiveLeadingToolBar {
                RetrospectiveToolBarItem(.symbol("chevron.left")) {
                    dismiss()
                }
            }
            .retrospectiveTrailingToolbar {
                RetrospectiveToolBarItem(.symbol("checkmark")) {
                    if editedName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        showEmptyNameAlert = true
                        return
                    }

                    let rgb = editedColor.rgbComponents()
                    category.name = editedName
                    category.setColor(red: rgb.red, green: rgb.green, blue: rgb.blue)
                    dismiss()
                }
            }
        }
        .alert("최소 한개 이상의 카테고리가 필요합니다.", isPresented: $showingMinimumCategoryAlert) {
            Button("확인", role: .cancel) { }
        }
        .alert("한 글자 이상 입력해 주세요.", isPresented: $showEmptyNameAlert) {
            Button("확인", role: .cancel) { }
        }
    }
    @ViewBuilder
    private func sliderView(value: Binding<Double>, label: String, color: Color) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                    .foregroundStyle(color)
                Spacer()
                Text("\(Int(value.wrappedValue))")
                    .foregroundStyle(color)
            }
            Slider(value: value, in: 0...255, step: 1) { isDragging in
                self.dragging = isDragging
            }
            .tint(color)
        }
        .padding(.horizontal)
    }
}

#Preview {
    let previewCategory = Category(name: "카테고리 이름", color: .blue)

    return EditCategoryView(category: previewCategory)
        .modelContainer(for: Category.self, inMemory: true)
}
