//
//  LoginView.swift
//  BookBetween
//
//  Created by 최윤석 on 7/9/26.
//

import SwiftUI

struct LoginView: View {
  var body: some View {
    ZStack {
      LoginBackgroundView()

      LoginContentView()
    }
  }
}

private struct LoginBackgroundView: View {
  var body: some View {
    ZStack {
      Color(red: 0.98, green: 0.98, blue: 0.98)
        .ignoresSafeArea()

      LinearGradient(
        stops: [
          Gradient.Stop(
            color: Color(red: 0.80, green: 0.88, blue: 0.82),
            location: 0.03
          ),
          Gradient.Stop(
            color: Color.white.opacity(0),
            location: 1.00
          )
        ],
        startPoint: UnitPoint(x: 0.52, y: 0.05),
        endPoint: UnitPoint(x: 0.52, y: 1.03)
      )
      .ignoresSafeArea()

      EllipticalGradient(
        stops: [
          Gradient.Stop(color: .white, location: 0.30),
          Gradient.Stop(color: .white.opacity(0), location: 1.00)
        ],
        center: UnitPoint(x: 0.5, y: 0.47)
      )
      .frame(width: 373, height: 376)
      .offset(y: -55)
    }
  }
}

private struct LoginContentView: View {
  var body: some View {
    VStack(spacing: 0) {
      Spacer()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

#Preview {
  LoginView()
}
