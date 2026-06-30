//
//  CustomTabBar.swift
//  BookBetween
//
//  Created by 이준성 on 6/25/26.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: TabCase

    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabCase.allCases, id: \.self) { tab in
                Spacer()

                Button {
                    selectedTab = tab
                } label: {
                    VStack(spacing: 6) {
                        Image(systemName: tab.iconName)
                            .font(.system(size: 19))
                            .foregroundStyle(selectedTab == tab ? .green800 : .gray400)

                        Text(tab.title)
                            .body2RegularStyle
                            .foregroundStyle(selectedTab == tab ? .green800 : .gray400)
                    }
                    .padding(.vertical, 10)
                }
                Spacer()
            }
        }
        .padding(.top, 5)
        .background {
            UnevenRoundedRectangle(topLeadingRadius: 12, topTrailingRadius: 12)
                .fill(Color.white)
                .ignoresSafeArea(edges: .bottom)
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: -6)
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(.home))
}
