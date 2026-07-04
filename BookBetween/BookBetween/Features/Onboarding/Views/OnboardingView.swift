//
//  OnboardingView.swift
//  BookBetween
//
//  Created by 최윤석 on 7/4/26.
//

import SwiftUI

struct OnboardingView: View {
  @StateObject private var viewModel = OnboardingViewModel()

  var body: some View {
    ZStack {
      OnboardingBackgroundView()

      VStack(spacing: 0) {
        self.topBar

        Spacer()
          .frame(height: 62)

        self.titleSection

        OnboardingPreviewCardView()

        Spacer()

        OnboardingPageIndicator(
          currentPage: self.viewModel.currentPageIndex,
          totalPage: self.viewModel.pages.count
        )
        .padding(.bottom, 32)

        OnboardingBottomButton(title: self.viewModel.bottomButtonTitle) {
          self.viewModel.nextButtonDidTap()
        }
      }
      .padding(.horizontal, 24)
      .padding(.bottom, 32)
    }
  }

  private var topBar: some View {
    HStack {
      Button {
      } label: {
        Image(systemName: "chevron.left")
          .font(.system(size: 28, weight: .regular))
          .foregroundStyle(Color.gray500)
      }

      Spacer()

      Button {
        self.viewModel.skipButtonDidTap()
      } label: {
        Text("건너뛰기")
          .body2RegularStyle
          .foregroundStyle(Color.gray600)
      }
    }
    .padding(.top, 24)
  }

  private var titleSection: some View {
    VStack(spacing: 16) {
      self.titleText

      Text(self.viewModel.currentPage.description)
        .body1RegularStyle
        .foregroundStyle(Color.gray700)
        .multilineTextAlignment(.center)
    }
    .padding(.bottom, 56)
  }

  @ViewBuilder
  private var titleText: some View {
    let page = self.viewModel.currentPage

    Group {
      if let highlightedTitle = page.highlightedTitle {
        HStack(spacing: 0) {
          Text(page.title)
            .head2Style
            .foregroundStyle(Color.gray900)

          Text(highlightedTitle)
            .head2Style
            .foregroundStyle(Color.green800)
        }
      } else {
        Text(page.title)
          .head2Style
          .foregroundStyle(Color.green800)
      }
    }
    .multilineTextAlignment(.center)
  }
}

#Preview {
  OnboardingView()
}
