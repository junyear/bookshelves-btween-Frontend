//
//  BookMeetingCardView.swift
//  BookBetween
//

import SwiftUI

struct BookMeetingCardView: View {
	let meeting: BookMeeting

	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			contentRow
		}
		.frame(height: 110)
		.padding(16)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay {
			RoundedRectangle(cornerRadius: 12)
				.stroke(Color.gray200, lineWidth: 1)
		}
		.shadow(color: .black.opacity(0.06), radius: 4, x: 0, y: 2)
	}

	// MARK: - Views

	private var contentRow: some View {
		HStack(alignment: .center, spacing: 12) {
			Image(meeting.book.thumbnailImageName ?? "book_cover_meeting_1")
				.resizable()
				.scaledToFill()
				.frame(width: 60, height: 93)
				.clipped()
				.shadow(color: .black.opacity(0.1), radius: 2, x: -1, y: 1)

			VStack(alignment: .leading, spacing: 6) {
					Text(meeting.status.title)
						.caption1SemiBoldStyle
						.foregroundStyle(meeting.status == .completed ? Color.white : Color.green600)
						.padding(.horizontal, 8)
						.padding(.vertical, 3)
						.background(meeting.status == .completed ? Color.green600 : Color.green50)
						.clipShape(Capsule())

				Text(meeting.book.title)
					.body2SemiBoldStyle
					.lineLimit(2)

				HStack(spacing: 4) {
					Image("icon_calendar")
					Text(meetingDateText)
						.caption2RegularStyle
					Text("|")
						.caption2RegularStyle
						.foregroundStyle(Color.gray300)
					Image("icon_group")
					Text("\(meeting.currentParticipants)/\(meeting.maxParticipants)")
						.caption2RegularStyle
				}
				.foregroundStyle(Color.gray500)
			}
				
			Spacer()
				VStack{
						NavigationLink {
							if meeting.status == .completed {
								BookMeetingResultView(meeting: meeting)
							} else {
								BookMeetingDetailView(meeting: meeting)
							}
						} label: {
							Text("더보기 >")
								.caption2RegularStyle
								.foregroundStyle(Color.gray400)
						}
						Spacer()
				}
				
		}
	}

	// MARK: - Helpers

	private var meetingDateText: String {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "ko_KR")
		formatter.dateFormat = "MM/dd · HH:mm"
		return formatter.string(from: meeting.meetingDate)
	}
}

#Preview {
	NavigationStack {
		BookMeetingCardView(
			meeting: BookMeeting(
				id: "preview-1",
				book: Book(
					id: "book-1",
					title: "빛은 얼마나 깊이 스미는가",
					author: "김초엽",
					description: nil,
					thumbnailURL: nil,
					thumbnailImageName: "book_cover_meeting_1"
				),
				title: nil,
				description: "",
				recruitmentStartDate: Date(),
				recruitmentEndDate: Date(),
				readingStartDate: Date(),
				readingEndDate: Date(),
				meetingDate: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 19, hour: 21)) ?? Date(),
				timerMinutes: 60,
				maxParticipants: 6,
				currentParticipants: 2,
				status: .completed
			)
		)
		.padding()
	}
}
