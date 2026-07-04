//
//  BookMeetingCreateView.swift
//  BookBetween
//

import SwiftUI

struct BookMeetingCreateView: View {
	@State private var meetingDate = Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 30, hour: 10)) ?? Date()
	@State private var timerMinutes = 30
	@State private var maxParticipants = 6
	@State private var showingMeetingDatePicker = false
	@State private var showingTimerPicker = false
	@State private var showingParticipantsPicker = false

	private static let dateTimeFormatter: DateFormatter = {
		let f = DateFormatter()
		f.dateFormat = "MM/dd HH:mm"
		return f
	}()

	private let book = Book(
		id: "book-create",
		title: "혼모노",
		author: "성해나",
		description: "성해나 작가의 단편 소설집 『혼모노』는 진짜와 가짜, 믿음에 대한 날카로운 질문을 던지는 작품입니다.\n표제작 『혼모노』는 신발을 읽고 20대 애기 무당에게 자리를 빼앗긴 베테랑 무당이 진정한 자신의 정체성을 찾아가는 과정을 그립니다.",
		thumbnailURL: nil,
		thumbnailImageName: "book_cover_meeting_1"
	)

	var body: some View {
		VStack(spacing: 0) {
			ScrollView(showsIndicators: false) {
				VStack(alignment: .leading, spacing: 0) {
					subtitleText
					bookHeaderSection
					descriptionText
					meetingInfoSection
					noticeSection
				}
				.padding(.bottom, 20)
			}

			bottomButton("+ 모임 생성하기") {}
		}
		.navigationTitle("독서 모임 생성하기")
		.navigationBarTitleDisplayMode(.inline)
	}

	// MARK: - Header

	private var subtitleText: some View {
		Text("같이 읽을 책과 모임 정보를 설정해주세요")
			.caption1RegularStyle
			.foregroundStyle(Color.gray500)
			.padding(.horizontal, 20)
			.padding(.top, 4)
			.padding(.bottom, 16)
	}

	private var bookHeaderSection: some View {
		ZStack(alignment: .topTrailing) {
			leafDecoration

			HStack(alignment: .top, spacing: 14) {
				Image(book.thumbnailImageName ?? "book_cover_meeting_1")
					.resizable()
					.scaledToFill()
					.frame(width: 100, height: 130)
					.clipped()
					.shadow(color: .black.opacity(0.15), radius: 6, x: -3, y: 3)

				VStack(alignment: .leading, spacing: 6) {
					Text(book.title)
						.head3Style

					Text(book.author)
						.caption1RegularStyle
						.foregroundStyle(Color.gray500)

					Text("#한국소설")
						.caption1SemiBoldStyle
						.foregroundStyle(Color.green800)
						.padding(.horizontal, 8)
						.padding(.vertical, 3)
						.background(Color.green50)
						.clipShape(Capsule())
				}
			}
			.padding(.horizontal, 20)
		}
	}

	private var leafDecoration: some View {
		Image(.leaf)
			.resizable()
			.scaledToFit()
			.frame(width: 170)
			.foregroundStyle(Color(hex: "C8DDB8").opacity(0.5))
			.rotationEffect(.degrees(-15))
			.offset(x: 40, y: -20)
			.allowsHitTesting(false)
	}

	private var descriptionText: some View {
		Text(book.description ?? "")
			.body2RegularStyle
			.foregroundStyle(Color.gray600)
			.padding(.horizontal, 20)
			.padding(.top, 16)
	}

	// MARK: - Meeting Info

	private var meetingInfoSection: some View {
		VStack(alignment: .leading, spacing: 12) {
			Text("모임정보")
				.body1SemiBoldStyle
				.padding(.horizontal, 20)

			meetingInfoCard
				.padding(.horizontal, 20)
		}
		.padding(.top, 24)
	}

	private var meetingInfoCard: some View {
		VStack(spacing: 0) {
			// 모임 날짜 — 탭하면 카드 내부에서 휠 펼침
			Button {
				withAnimation(.easeInOut(duration: 0.2)) {
					showingTimerPicker = false
					showingParticipantsPicker = false
					showingMeetingDatePicker.toggle()
				}
			} label: {
				HStack {
					Image("icon_calendar")
					Text("모임 날짜")
						.body2RegularStyle
						.foregroundStyle(Color.gray700)
					Spacer()
					Text(Self.dateTimeFormatter.string(from: meetingDate))
						.body2RegularStyle
						.foregroundStyle(Color.gray700)
				}
				.padding(.horizontal, 16)
				.padding(.vertical, 14)
			}
			.buttonStyle(.plain)

			if showingMeetingDatePicker {
				DatePicker("", selection: $meetingDate, displayedComponents: [.date, .hourAndMinute])
					.datePickerStyle(.wheel)
					.labelsHidden()
					.frame(height: 150)
					.clipped()
					.padding(.horizontal, 8)
					.transition(.opacity.combined(with: .move(edge: .top)))
			}

			Divider()

			// 타이머 시간 — 탭하면 카드 내부에서 휠 펼침
			Button {
				withAnimation(.easeInOut(duration: 0.2)) {
					showingMeetingDatePicker = false
					showingParticipantsPicker = false
					showingTimerPicker.toggle()
				}
			} label: {
				HStack {
					Image(systemName: "clock")
						.foregroundStyle(Color.gray500)
					Text("타이머 시간")
						.body2RegularStyle
						.foregroundStyle(Color.gray700)
					Spacer()
					Text("\(timerMinutes)분")
						.body2RegularStyle
						.foregroundStyle(Color.gray700)
				}
				.padding(.horizontal, 16)
				.padding(.vertical, 14)
			}
			.buttonStyle(.plain)

			if showingTimerPicker {
				Picker("타이머 시간", selection: $timerMinutes) {
					ForEach(Array(stride(from: 15, through: 180, by: 15)), id: \.self) { minutes in
						Text("\(minutes)분").tag(minutes)
					}
				}
				.pickerStyle(.wheel)
				.frame(height: 150)
				.padding(.horizontal, 8)
				.transition(.opacity.combined(with: .move(edge: .top)))
			}

			Divider()

			// 참여자 — 탭하면 카드 내부에서 휠 펼침
			Button {
				withAnimation(.easeInOut(duration: 0.2)) {
					showingMeetingDatePicker = false
					showingTimerPicker = false
					showingParticipantsPicker.toggle()
				}
			} label: {
				HStack {
					Image("icon_group")
					Text("참여자")
						.body2RegularStyle
						.foregroundStyle(Color.gray700)
					Spacer()
					Text("\(maxParticipants)명")
						.body2RegularStyle
						.foregroundStyle(Color.gray700)
				}
				.padding(.horizontal, 16)
				.padding(.vertical, 14)
			}
			.buttonStyle(.plain)

			if showingParticipantsPicker {
				Picker("참여자", selection: $maxParticipants) {
					ForEach(3...20, id: \.self) { count in
						Text("\(count)명").tag(count)
					}
				}
				.pickerStyle(.wheel)
				.frame(height: 150)
				.padding(.horizontal, 8)
				.transition(.opacity.combined(with: .move(edge: .top)))
			}
		}
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay {
			RoundedRectangle(cornerRadius: 12)
				.stroke(Color.gray200, lineWidth: 1)
		}
	}

	// MARK: - Notice

	private var noticeSection: some View {
		HStack(alignment: .top, spacing: 10) {
			Image(systemName: "leaf.fill")
				.foregroundStyle(Color.green600)
				.font(.caption)
				.padding(.top, 2)

			VStack(alignment: .leading, spacing: 4) {
				Text("모임은 타이머 설정 시간 만료 후  자동으로 폭파돼요.")
					.caption1SemiBoldStyle
					.foregroundStyle(Color.gray700)

				Text("편안하고 안전한 대화를 위해 최소인원 3명 이상이 필요해요.")
					.caption1RegularStyle
					.foregroundStyle(Color.gray500)
			}
		}
		.padding(12)
		.background(Color.green50)
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.padding(.horizontal, 20)
		.padding(.top, 16)
	}
}

#Preview {
	NavigationStack {
		BookMeetingCreateView()
	}
}
