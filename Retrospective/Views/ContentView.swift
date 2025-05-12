//
//  ContentView.swift
//  Retrospective
//
//  Created by 김건우 on 5/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false

    var body: some View {
        VStack {
            Button("FloatingSheet") {
                isPresented.toggle()
            }
        }
        .padding()
        .floatingSheet(isPresented: $isPresented, onDismiss: { print("dismissed") }) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Marget Caplitalization")
                    .font(.title2)
                    .fontWeight(.bold)

                Text("As of February 3rd, US Time")
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                VStack {
                    Text("Stock Price * Shares Outstanding")
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
}

#Preview {
    ContentView()
        .modelContainer(PersistenceManager.previewContainer)
}
