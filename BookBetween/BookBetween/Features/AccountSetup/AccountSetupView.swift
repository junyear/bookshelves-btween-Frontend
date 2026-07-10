//
//  AccountSetupView.swift
//  BookBetween
//
//  Created by 최윤석 on 7/10/26.
//

import SwiftUI

// MARK: - 계정 설정 화면

struct AccountSetupView: View {
  var body: some View {
    ZStack {
      AccountSetupBackgroundView()

      AccountSetupContentView()
    }
  }
}

// MARK: - 배경 베이지색 + 양옆 나뭇잎 장식

private struct AccountSetupBackgroundView: View {
  var body: some View {
    ZStack {
      Color.beige100
        .ignoresSafeArea()

      AccountSetupLeafDecorationView()
    }
  }
}

// MARK: - 나뭇잎 장식

private struct AccountSetupLeafDecorationView: View {
  var body: some View {
    GeometryReader { _ in
      ZStack {
        Image("accountSetupLeaf")
          .resizable()
          .scaledToFit()
          .frame(width: 123.45, height: 138.25)
          .position(x: 65, y: 95)

        Image("accountSetupLeafRight")
          .resizable()
          .scaledToFit()
          .frame(width: 122.96, height: 137.71)
          .position(x: 344.30, y: 210)
      }
    }
    .ignoresSafeArea()
  }
}

// MARK: - 콘텐츠 영역

private struct AccountSetupContentView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      AccountSetupTitleSectionView()
        .padding(.top, 126)

      AccountSetupNicknameSectionView()
        .padding(.top, 36)

      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
  }
}

// MARK: - 제목 영역

private struct AccountSetupTitleSectionView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text("계정 설정")
        .head1Style
        .foregroundStyle(Color.gray800)

      Text("나중에 수정할 수 있어요")
        .caption1SemiBoldStyle
        .foregroundStyle(Color.gray500)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.leading, 26)

  }
}

// MARK: - 닉네임 설정 영역

private struct AccountSetupNicknameSectionView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      Text("닉네임")
        .body1SemiBoldStyle
        .foregroundStyle(Color.gray800)
        .padding(.leading, 30)


      AccountSetupNicknameInputView()
        .padding(.top, 8)
        .padding(.horizontal, 19)

      Text("다른 사용자에게 표시되는 이름이에요.")
        .body2RegularStyle
        .foregroundStyle(Color.gray500)
        .padding(.top, 8)
        .padding(.leading, 30)

    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

// MARK: - 닉네임 입력 박스

private struct AccountSetupNicknameInputView: View {
  var body: some View {
    HStack(spacing: 0) {
      Text("랜덤 닉네임을 생성해보세요")
        .body1RegularStyle
        .foregroundStyle(Color.gray500)

      Spacer()

      AccountSetupNicknameRefreshButton()
    }
    .padding(.leading, 18)
    .padding(.trailing, 22.12)
    .frame(height: 46)
    .background(
        LinearGradient(
            stops: [
                Gradient.Stop(color: Color(red: 0.98, green: 0.98, blue: 0.99).opacity(0.4), location: 0.00),
                Gradient.Stop(color: .white, location: 0.72),
            ],
            startPoint: UnitPoint(x: 0.87, y: 0),
            endPoint: UnitPoint(x: 0.13, y: 1)
        )
    )
    .cornerRadius(12)
    .overlay {
        RoundedRectangle(cornerRadius: 12)
        .inset(by: 0.25)
        .stroke(Color.gray200, lineWidth: 0.5)
    }
    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 4)  }
}

// MARK: - 닉네임 새로고침 버튼

private struct AccountSetupNicknameRefreshButton: View {
  var body: some View {
    Button {
    } label: {
      Image("refresh")
        .frame(width: 19.49956, height: 19.50294)
    }
  }
}






#Preview {
  AccountSetupView()
}
