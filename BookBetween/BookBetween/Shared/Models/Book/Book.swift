//
//  Book.swift
//  BookBetween
//
//  Created by 이준성 on 7/2/26.
//

import Foundation

struct Book {
	let id: String
	let title: String
	let author: String
	let publisher: String?
	let description: String?
	let thumbnailURL: String? //책 표지 이미지 주소
	let thumbnailImageName: String? // MockUpdata 용으로 추가. (임시)
	let genre: String?

	init(
		id: String,
		title: String,
		author: String,
		publisher: String? = nil,
		description: String? = nil,
		thumbnailURL: String? = nil,
		thumbnailImageName: String? = nil,
		genre: String? = nil
	) {
		self.id = id
		self.title = title
		self.author = author
		self.publisher = publisher
		self.description = description
		self.thumbnailURL = thumbnailURL
		self.thumbnailImageName = thumbnailImageName
		self.genre = genre
	}
}
