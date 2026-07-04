//
//  BookMeetingDetailView.swift
//  BookBetween
//

import SwiftUI

struct BookMeetingDetailView: View {
	let meeting: BookMeeting

	var body: some View {
		VStack(spacing: 0) {
			ScrollView(showsIndicators: false) {
				VStack(alignment: .leading, spacing: 0) {
					bookHeader
					meetingDescriptionText
					meetingInfoSection
					noticeSection
				}
				.padding(.bottom, 20)
			}

			bottomButton("모임 참여하기") {}
		}
		.navigationTitle("독서 모임")
		.navigationBarTitleDisplayMode(.large)
	}

	// MARK: - Views

	private var bookHeader: some View {
		HStack(alignment: .top, spacing: 14) {
			Image(meeting.book.thumbnailImageName ?? "book_cover_meeting_1")
				.resizable()
				.scaledToFill()
				.frame(width: 120, height: 160)
				.clipped()
				.shadow(color: .black.opacity(0.15), radius: 6, x: -3, y: 3)

			VStack(alignment: .leading, spacing: 8) {
				Text(meeting.book.title)
					.head3Style

				Text(meeting.book.author)
					.caption1RegularStyle
					.foregroundStyle(Color.gray500)

				HStack(spacing: 4) {
					Image(systemName: "star.fill")
						.font(.caption)
						.foregroundStyle(.yellow)
					Text("4.5")
						.body2RegularStyle
				}

				Text(meeting.book.description ?? "끝없이 '진짜'와 '가짜'의 사이를 오가며 '혼모노'란 무엇인지 그 경계에서 질문을 던지는 소설")
					.body2RegularStyle
					.foregroundStyle(Color.gray600)
					.lineLimit(4)
			}
		}
		.padding(.horizontal, 20)
		.padding(.top, 4)
	}

	private var meetingDescriptionText: some View {
		Text("\(meeting.timerMinutes)분 동안 이루어지는 책에 대한 깊은 대화")
			.caption1RegularStyle
			.foregroundStyle(Color.gray500)
			.padding(.horizontal, 20)
			.padding(.top, 10)
	}

	private var meetingInfoSection: some View {
		VStack(alignment: .leading, spacing: 12) {
			HStack(spacing: 6) {
				Image("icon_calendar")
				Text("모임정보")
					.body1SemiBoldStyle
			}

			meetingInfoCard
		}
		.padding(.horizontal, 20)
		.padding(.top, 24)
	}

	private var meetingInfoCard: some View {
		VStack(spacing: 0) {
			infoRow(icon: { Image("icon_calendar") }, label: "모집 기간", value: dateRangeText(meeting.recruitmentStartDate, meeting.recruitmentEndDate))
			Divider()
			infoRow(icon: { Image("icon_calendar") }, label: "독서 기간", value: dateRangeText(meeting.readingStartDate, meeting.readingEndDate))
			Divider()
			infoRow(icon: { Image("icon_calendar") }, label: "모임 날짜", value: meetingDateText)
			Divider()
			infoRow(icon: { Image(systemName: "clock").foregroundStyle(Color.gray500) }, label: "타이머 시간", value: "\(meeting.timerMinutes)분")
			Divider()
			infoRow(icon: { Image("icon_group") }, label: "참여자", value: "\(meeting.maxParticipants)명")
		}
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay {
			RoundedRectangle(cornerRadius: 12)
				.stroke(Color.gray200, lineWidth: 1)
		}
	}

	private func infoRow<Icon: View>(
		@ViewBuilder icon: () -> Icon,
		label: String,
		value: String
	) -> some View {
		HStack {
			icon()
			Text(label)
				.body2RegularStyle
				.foregroundStyle(Color.gray700)
			Spacer()
			Text(value)
				.body2RegularStyle
				.foregroundStyle(Color.gray700)
		}
		.padding(.horizontal, 16)
		.padding(.vertical, 14)
	}

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

	// MARK: - Helpers

	private func dateRangeText(_ start: Date, _ end: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM/dd"
		return "\(formatter.string(from: start)) - \(formatter.string(from: end))"
	}

	private var meetingDateText: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "MM/dd HH:mm"
		return formatter.string(from: meeting.meetingDate)
	}
}

// MARK: - Shared Bottom Button

func bottomButton(_ title: String, action: @escaping () -> Void) -> some View {
	Button(action: action) {
		Text(title)
			.body1SemiBoldStyle
			.foregroundStyle(.white)
			.frame(maxWidth: .infinity)
			.padding(.vertical, 16)
			.background(Color.green800)
			.clipShape(RoundedRectangle(cornerRadius: 10))
	}
	.padding(.horizontal, 20)
	.padding(.top, 8)
	.padding(.bottom, 16)
	.background(.white)
}

#Preview {
	NavigationStack {
		BookMeetingDetailView(
			meeting: BookMeeting(
				id: "preview-detail",
				book: Book(
					id: "book-1",
					title: "혼모노",
					author: "성해나",
					description: "끝없이 '진짜'와 '가짜'의 사이를 오가며 '혼모노'란 무엇인지 그 경계에서 질문을 던지는 소설",
					thumbnailURL: nil,
					thumbnailImageName: "book_cover_meeting_1"
				),
				title: nil,
				description: "",
				recruitmentStartDate: Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 18)) ?? Date(),
				recruitmentEndDate: Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 24)) ?? Date(),
				readingStartDate: Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 25)) ?? Date(),
				readingEndDate: Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 28)) ?? Date(),
				meetingDate: Calendar.current.date(from: DateComponents(year: 2026, month: 11, day: 30, hour: 19)) ?? Date(),
				timerMinutes: 60,
				maxParticipants: 6,
				currentParticipants: 4,
				status: .upcoming
			)
		)
	}
}
