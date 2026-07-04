//
//  BookMeetingDiscussion.swift
//  BookBetween
//

import Foundation

struct DiscussionTopic: Identifiable {
	let id: Int
	let question: String
	let content: String
	let quote: String?
}

struct BookMeetingDiscussion {
	let meeting: BookMeeting
	let topics: [DiscussionTopic]
	let keywords: [String]
}
