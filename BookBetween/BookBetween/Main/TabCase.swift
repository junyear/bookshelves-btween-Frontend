//
//  TabCase.swift
//  BookBetween
//
//  Created by 이준성 on 6/25/26.
//

import Foundation

enum TabCase: Int, CaseIterable {
    case home, search, bookClub, myLibrary, profile

    var title: String {
        switch self {
        case .home:    return "홈"
        case .search:  return "검색"
        case .bookClub:   return "모임"
        case .myLibrary: return "내 서재"
        case .profile:      return "마이"
        }
    }

    var iconName: String {
        switch self {
        case .home:    return "house"
        case .search:  return "magnifyingglass"
        case .bookClub:   return "person.2"
        case .myLibrary: return "book"
        case .profile:      return "person"
        }
    }
}
