//
//  MainTabView.swift
//  BookBetween
//
//  Created by 이준성 on 6/25/26.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabCase = .home

    var body: some View {
        TabView(selection: $selectedTab) { // 추후 알림에 따른 화면 전환 등 새로운 로직 발생시 NavigationPath로 확장
            NavigationStack {
                HomeView()
            }
            .tag(TabCase.home)

            NavigationStack {
                SearchView()
            }
            .tag(TabCase.search)

            NavigationStack {
                BookClubView()
            }
            .tag(TabCase.bookClub)

            NavigationStack {
                MyLibraryView()
            }
            .tag(TabCase.myLibrary)

            NavigationStack {
                ProfileView()
            }
            .tag(TabCase.profile)
        }
        .toolbar(.hidden, for: .tabBar)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

#Preview {
    MainTabView()
}
