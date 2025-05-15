//
//  OnboardingView.swift
//  Retrospective
//
//  Created by 정소이 on 5/15/25.
//

import SwiftUI

struct OnboardingView: View {

    @Environment(\.dismiss) var dismiss

    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .label
        UIPageControl.appearance().pageIndicatorTintColor = .secondaryLabel
    }

    var body: some View {
        TabView {
            VStack {
                HStack{
                    Text("Our\nCamp\nDiary")
                        .font(.system(size: 70))
                        .fontWeight(.heavy)
                        .padding()

                    Spacer()
                }
                .padding(.top, 60)
                .padding(.leading, 20)

                Spacer()

                HStack {
                    Spacer()

                    Image(systemName: "pencil.and.scribble")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 230, height: 230)
                        .foregroundStyle(.appBlue)
                        .padding(.trailing, 50)
                }
            }

            VStack(spacing: 20){
                Text("즐거운 날에도")
                Text("슬픈 날에도")
                Text("그저그런 날에도")
            }
            .font(.system(size: 30))
            .fontWeight(.semibold)

            VStack {
                Image(systemName: "eyes")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.label)
                    .padding()

                Text("간편하게")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                    .padding()

                Text("그날의 추억을 기록해보세요")
                    .font(.title2)

                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("기록 시작하기")
                        Image(systemName: "arrow.right.circle.fill")
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(.label)
                    .padding()
                    .cornerRadius(.appLightGray.opacity(0.33), radius: 36)

                }
                .padding(.top, 30)
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    OnboardingView()
}
