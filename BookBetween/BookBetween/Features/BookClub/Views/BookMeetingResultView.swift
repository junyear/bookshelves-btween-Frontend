//
//  BookMeetingResultView.swift
//  BookBetween
//

import SwiftUI

struct BookMeetingResultView: View {
	let meeting: BookMeeting

	private var discussion: BookMeetingDiscussion {
		BookMeetingDiscussion(
			meeting: self.meeting,
			topics: [
				DiscussionTopic(
					id: 1,
					question: "왜 싯다르타는 계속 떠났을까?",
					content: "많은 참여자들은 싯다르타가 깨달음을 얻기 위해서가 아니라, 타인의 답을 자신의 답으로 받아들일 수 없었기 때문에 떠났다고 이야기했다.",
					quote: nil
				),
				DiscussionTopic(
					id: 2,
					question: "가장 인상 깊었던 시기",
					content: "참여자들은 의외로 싯다르타가 성공과 쾌락을 경험하던 시기를 많이 언급했다. 완벽한 실패와 방황과 실패의 시간이 있었기에 마지막 깨달음이 의미 있게 다가왔다는 의견이 많았다.",
					quote: nil
				),
				DiscussionTopic(
					id: 3,
					question: "현재의 나와 연결되는 부분",
					content: "많은 참여자들이 진로 고민, 인간관계, 미래에 대한 불안을 이야기하며 싯다르타의 방황과 자신의 삶을 연결 지었다. 특히 '남들과 비교하여 조급해질 때가 많다.'는 이야기에 여러 참여자가 공감했다.",
					quote: nil
				)
			],
			keywords: []
		)
	}

	var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(alignment: .leading, spacing: 0) {
				bookHeaderSection
				discussionSection
			}
			.padding(.bottom, 40)
		}
		.navigationTitle("독서 모임")
		.navigationBarTitleDisplayMode(.inline)
	}

	// MARK: - Book Header

	private var bookHeaderSection: some View {
		ZStack(alignment: .topTrailing) {
			leafDecoration

			HStack(alignment: .top, spacing: 14) {
				Image(meeting.book.thumbnailImageName ?? "book_cover_meeting_1")
					.resizable()
					.scaledToFill()
					.frame(width: 100, height: 136)
					.clipped()
					.shadow(color: .black.opacity(0.15), radius: 6, x: -3, y: 3)

				VStack(alignment: .leading, spacing: 6) {
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
					.padding(.bottom, 4)

					compactInfoRows
				}
			}
			.padding(.horizontal, 20)
			.padding(.vertical, 20)
		}
	}

	private var leafDecoration: some View {
		Image(systemName: "leaf.fill")
			.resizable()
			.scaledToFit()
			.frame(width: 130)
			.foregroundStyle(Color(hex: "C8DDB8").opacity(0.55))
			.rotationEffect(.degrees(-20))
			.offset(x: 10, y: -16)
			.allowsHitTesting(false)
	}

	private var compactInfoRows: some View {
		VStack(alignment: .leading, spacing: 4) {
			compactInfoRow(icon: { Image("icon_calendar") }, text: "독서 기간: 11/25 - 11/28")
			compactInfoRow(icon: { Image("icon_calendar") }, text: "모임 날짜: 11/30 19:00")
			compactInfoRow(icon: { Image(systemName: "clock").foregroundStyle(Color.gray500) }, text: "모임 시간: \(meeting.timerMinutes)분")
			compactInfoRow(icon: { Image("icon_group") }, text: "참여자: \(meeting.maxParticipants)명")
		}
	}

	private func compactInfoRow<Icon: View>(
		@ViewBuilder icon: () -> Icon,
		text: String
	) -> some View {
		HStack(spacing: 4) {
			icon()
			Text(text)
				.caption2RegularStyle
				.foregroundStyle(Color.gray500)
		}
	}

	// MARK: - Discussion

	private var discussionSection: some View {
		VStack(spacing: 0) {
			ForEach(discussion.topics.indices, id: \.self) { index in
				topicRow(discussion.topics[index])
				if index < discussion.topics.count - 1 {
					Divider()
						.padding(.horizontal, 20)
				}
			}
		}
	}

	private func topicRow(_ topic: DiscussionTopic) -> some View {
		VStack(alignment: .leading, spacing: 10) {
			HStack(alignment: .top, spacing: 10) {
				ZStack {
					Circle()
						.fill(Color.green800)
						.frame(width: 24, height: 24)
					Text("\(topic.id)")
						.font(.system(size: 10, weight: .semibold))
						.foregroundStyle(.white)
				}

				Text(topic.question)
					.body1SemiBoldStyle
					.foregroundStyle(Color.gray800)
					.fixedSize(horizontal: false, vertical: true)
			}

			Text(topic.content)
				.body2RegularStyle
				.foregroundStyle(Color.gray600)
		}
		.padding(.horizontal, 20)
		.padding(.vertical, 20)
	}
}

#Preview {
	NavigationStack {
		BookMeetingResultView(
			meeting: BookMeeting(
				id: "preview-result",
				book: Book(
					id: "book-1",
					title: "혼모노",
					author: "성해나",
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
				meetingDate: Date(),
				timerMinutes: 60,
				maxParticipants: 6,
				currentParticipants: 6,
				status: .completed
			)
		)
	}
}
