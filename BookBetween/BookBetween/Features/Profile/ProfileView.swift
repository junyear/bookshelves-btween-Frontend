//
//  ProfileView.swift
//  BookBetween
//
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                Text("마이페이지")
                    .head2Style
                    .foregroundStyle(Color.gray900)
                    .padding(.bottom, 16)

                profileCard
                    .padding(.bottom, 50)

                readingStatisticsCard
                    .padding(.bottom, 16)

                Text("독서 캘린더")
                    .head2Style
                    .foregroundStyle(Color.gray900)
                    .padding(.bottom, 18)

                readingCalendar
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 120)
        }
        .background(Color.beige100)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var profileCard: some View {
        HStack(spacing: 23) {
            profileImage

            VStack(alignment: .leading, spacing: 0) {
                Text("책먹는 여우님")
                    .head3Style
                    .foregroundStyle(Color.gray800)
                    .padding(.bottom, 5)

                Text("가입 124일")
                    .body2RegularStyle
                    .foregroundStyle(Color.gray600)
                    .padding(.bottom, 8)

                editProfileButton
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, 15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 130)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray200, lineWidth: 0.5)
        }
    }

    private var profileImage: some View {
        ZStack {
            Circle()
                .fill(Color.yellow.opacity(0.35))

            Image("ex_animal")
                .resizable()
                .scaledToFit()
        }
        .frame(width: 100, height: 100)
        .clipShape(Circle())
        .overlay {
            Circle()
                .stroke(Color.white, lineWidth: 2.5)
        }
        // 그림자 추후에 값 수정해야함
        .shadow(color: Color.black.opacity(0.1), radius: 2, y: 2)
    }

    private var editProfileButton: some View {
        Button {
            // 프로필 수정 화면 연결 시 동작 추가해야함
        } label: {
            HStack(spacing: 4) {
                Image("icon_pencil")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)

                Text("정보 수정하기")
                    .caption1RegularStyle
            }
            .foregroundStyle(Color.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .background(Color.green700)
            .cornerRadius(12)
        }
    }

    private var readingStatisticsCard: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .frame(height: 110)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray200, lineWidth: 0.5)
            }
    }

    private var readingCalendar: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .frame(height: 391)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray300, lineWidth: 0.5)
            }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
