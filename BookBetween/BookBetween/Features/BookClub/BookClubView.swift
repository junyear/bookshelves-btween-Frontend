import SwiftUI

struct BookClubView: View {
	@State private var viewModel = BookClubViewModel()
	@State private var currentMeetingPage = 0
	private let bookGridColumns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

	var body: some View {
		VStack(spacing: 0) {
			HStack {
				Text("모임 관리")
					.head2Style
				Spacer()
			}
			.padding(.horizontal, 30)
			.padding(.top, 17)
			.padding(.bottom, 12)

			tabSelector
				.padding(.horizontal, 30)

			if viewModel.selectedTab == .search {
				searchContent
			} else {
				ScrollView(showsIndicators: false) {
					VStack(spacing: 12) {
						if viewModel.selectedTab == .myMeetings {
							meetingList(viewModel.participatingMeetings)
						} else {
							meetingList(viewModel.createdMeetings)
						}
					}
                    .padding(.horizontal, 19)
                    .padding(.top, 32)
				}
				.scrollBounceBehavior(.basedOnSize)
			}
		}
		.background(Color.beige100)
		.toolbar(.hidden, for: .navigationBar)
	}

	// MARK: - Tab Selector

	private var tabSelector: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 8) {
				ForEach(BookClubTab.allCases, id: \.self) { tab in
					tabPill(for: tab)
				}
			}
		}
	}

	private func tabPill(for tab: BookClubTab) -> some View {
		Button {
			viewModel.selectedTab = tab
		} label: {
			Text(tab.title)
				.caption1SemiBoldStyle
				.foregroundStyle(viewModel.selectedTab == tab ? Color.beige100 : Color.gray300)
				.padding(.horizontal, tab.horizontalPadding)
				.padding(.vertical, 5)
				.background(viewModel.selectedTab == tab ? Color.green600 : Color.beige100)
				.clipShape(Capsule())
				.overlay(Capsule().stroke(Color.gray300, lineWidth: viewModel.selectedTab == tab ? 0 : 1))
		}
	}

	// MARK: - Meeting List (참여/내가 만든)

	@ViewBuilder
	private func meetingList(_ meetings: [BookMeeting]) -> some View {
		ForEach(meetings, id: \.id) { meeting in
			BookMeetingCardView(meeting: meeting)
		}
	}

	// MARK: - Search

	private var searchContent: some View {
		VStack(spacing: 16) {
			searchBar
                .padding(.horizontal, 19)
                .padding(.top, 16)

			ScrollView(showsIndicators: false) {
				VStack(alignment: .leading, spacing: 12) {
					if !viewModel.searchText.isEmpty {
						if !viewModel.meetingSearchResults.isEmpty || !viewModel.bookSearchResults.isEmpty {
							meetingResultsSection
							bookResultsSection
						} else {
							Text("검색결과가 없습니다")
								.body2RegularStyle
								.foregroundStyle(Color.gray400)
								.frame(maxWidth: .infinity)
								.padding(.top, 48)
						}
					}
				}
				.padding(.top, 16)
			}
			.scrollBounceBehavior(.basedOnSize)
		}
		.onChange(of: viewModel.searchText) {
			currentMeetingPage = 0
		}
	}

    // MARK: - searchBar
    
	private var searchBar: some View {
        HStack(spacing: 10.42) {
            Image(.iconMagnifyingglass)
                .resizable()
                .scaledToFill()
                .frame(width: 20, height: 20)
                .clipped()
				.foregroundStyle(Color.gray600)

			TextField("모임 검색", text: Bindable(viewModel).searchText)
				.font(.body1Regular)
                .foregroundStyle(Color.gray500)
		}
		.padding(.horizontal, 11)
		.padding(.top, 12)
        .padding(.bottom, 14)
		.background(.white)
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.overlay {
			RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray200, lineWidth: 0.5)
		}
        .shadow3()
	}

	// MARK: - Meeting Results

	private var meetingPages: [[BookMeeting]] {
		let pages = stride(from: 0, to: viewModel.meetingSearchResults.count, by: 3).map { start in
			Array(viewModel.meetingSearchResults[start..<min(start + 3, viewModel.meetingSearchResults.count)])
		}
		return Array(pages.prefix(3))
	}

	@ViewBuilder
	private var meetingResultsSection: some View {
		if !viewModel.meetingSearchResults.isEmpty {
			VStack(alignment: .leading, spacing: 12) {
                ForEach(meetingPages[currentMeetingPage], id: \.id) { meeting in
                    BookMeetingCardView(meeting: meeting)
                }
                
				pageIndicator
                    .padding(.bottom, 42)
			}
            .padding(.horizontal, 19)
		}
	}

	private var pageIndicator: some View {
		HStack(spacing: 12) {
			Button {
				if currentMeetingPage > 0 { currentMeetingPage -= 1 }
			} label: {
                Image(.iconChevronLeft)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 6, height: 12)
                    .clipped()
                    .foregroundStyle(Color.gray600)
			}

			ForEach(0..<meetingPages.count, id: \.self) { page in
				Button {
					currentMeetingPage = page
				} label: {
					Text("\(page + 1)")
                        .font(.body2Regular)
						.foregroundStyle(page == currentMeetingPage ? Color.gray50 : Color.gray600)
						.frame(width: 26, height: 26)
						.background(page == currentMeetingPage ? Color.green700 : Color.clear)
						.clipShape(Circle())
				}
			}

			Button {
				if currentMeetingPage < meetingPages.count - 1 { currentMeetingPage += 1 }
			} label: {
                Image(.iconChevronRight)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 6, height: 12)
                    .clipped()
                    .foregroundStyle(Color.gray600)
			}
		}
		.frame(maxWidth: .infinity)
		.padding(.top, 92)
	}

	// MARK: - Book Results (가로 스크롤)

	@ViewBuilder
	private var bookResultsSection: some View {
		if !viewModel.bookSearchResults.isEmpty {
			VStack(spacing: 0) {
                Text("도서 목록")
                    .pointText4Style
                    .foregroundStyle(Color.gray800)
                    .padding(.bottom, 5.14)
                
				HStack(spacing: 0) {
                    Rectangle()
                        .frame(width: 110, height: 1)
                        .foregroundStyle(Color.gray400)
                    Spacer()
                    Rectangle()
                        .frame(width: 110, height: 1)
                        .foregroundStyle(Color.gray400)

				}
                .padding(.bottom, 6.86)
                .padding(.horizontal, 7)
                
				Text("아래 목록에서 도서를 선택해보세요")
					.caption1RegularStyle
					.foregroundStyle(Color.gray400)
					.frame(maxWidth: .infinity, alignment: .center)

				ScrollView(.horizontal, showsIndicators: false) {
					HStack(spacing: 20) {
						ForEach(viewModel.bookSearchResults, id: \.id) { book in
							NavigationLink {
								BookMeetingCreateView(book: book)
							} label: {
								BookSearchCardView(book: book)
							}
						}
					}
                    .padding(.top, 24.14)
					.padding(.horizontal, 27)
					.padding(.bottom, 54)
				}
			}
		}
	}
}

#Preview {
	NavigationStack {
		BookClubView()
	}
}
