//
//  OnboardingPage.swift
//  BookBetween
//
//  Created by 최윤석 on 7/4/26.
//

import Foundation

struct OnboardingPage: Identifiable {
  let id: Int
  let title: String
  let highlightedTitle: String?
  let description: String

  var fullTitle: String {
    guard let highlightedTitle else {
      return self.title
    }

    return self.title + highlightedTitle
  }
}
