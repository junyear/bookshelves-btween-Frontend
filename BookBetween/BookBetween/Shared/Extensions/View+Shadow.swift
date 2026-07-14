import SwiftUI

extension View {
	func shadow1() -> some View {
		self.shadow(color: Color(hex: "2B2A28").opacity(0.10), radius: 2, x: 0, y: 2)
	}

	func shadow2() -> some View {
		self.shadow(color: Color(hex: "54524E").opacity(0.20), radius: 3, x: 0, y: 3)
	}

	func shadow3() -> some View {
		self.shadow(color: Color(hex: "2B2A28").opacity(0.10), radius: 4, x: 0, y: 4)
	}
}
