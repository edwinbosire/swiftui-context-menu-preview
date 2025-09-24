//
//  ContextMenu.swift
//  ContextMenu
//
//  Created by Edwin Bosire on 23/09/2025.
//

import SwiftUI

struct ContextMenu: View {
	let contentFillColor: Color = .gray.opacity(0.2)

	let items = Array(1...20)
	let columns = [GridItem(.flexible()), GridItem(.flexible())]

	var body: some View {
		VStack {
			Header
				.frame(height: 40)
				.padding(.horizontal)

			ScrollView {
				LazyVGrid(columns: columns, spacing: 8) {
					ForEach(items, id: \.self) { item in
						customCell(item, fillColor: Color.random)
							.frame(height: 280)
					}
				}
				.padding()
			}
			.background(Color.gray.opacity(0.15)
				.ignoresSafeArea(edges: .top))
		}
	}

	var Header: some View {
		HStack {
			Circle()
				.fill(contentFillColor)
				.overlay {
					Image(.profile)
						.resizable()
						.padding(2)
				}

			Capsule()
				.fill(contentFillColor)
				.overlay {
					Capsule()
						.fill(.white)
						.padding(2)
				}
				.overlay(alignment: .leading) {
					HStack {
						Image(systemName: "magnifyingglass")
						Text("Search")
							.font(.body)
					}
					.foregroundStyle(.tertiary)
					.padding(.leading)

				}

			Image(systemName: "quote.bubble")
				.font(.title2)
				.foregroundStyle(.gray.opacity(0.6))

		}
	}

	func Content(fillColor: Color) -> some View {
		VStack {
			HStack(alignment: .top) {
				Circle()
					.fill(contentFillColor)
					.layoutPriority(1)
				VStack(alignment: .leading) {
					Capsule()
						.fill(contentFillColor)

					Capsule()
						.fill(contentFillColor)
						.padding(.trailing, 30)
				}
				.frame(height: 30)
				.layoutPriority(1)
			}
			.frame(height: 30, alignment: .top)
			.padding(.horizontal)


			RoundedRectangle(cornerRadius: 12)
				.fill(fillColor.opacity(0.9))
				.padding(.horizontal, 8)
		}
		.padding(.vertical)
	}

	@ViewBuilder
	func customCell(_ item: Int, fillColor: Color) -> some View {
		Content(fillColor: fillColor)
			.background(Color.gray.opacity(0.1).gradient, in: .rect(cornerRadius: 12))
			.contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 12))
			.contextMenu {
				ControlGroup(content: {
					Button(action: {}, label: {
						Image(systemName: "heart.fill")
							.foregroundStyle(.red)
					})
					.tint(.red)
					Button(action: {}, label: {
						Image(systemName: "quote.bubble")
					})
					.tint(.blue)
					Button(action: {}, label: {
						Image(systemName: "arrow.2.squarepath")
							.foregroundStyle(.purple)
					})
					.tint(.purple)
					Button(role: .cancel, action: {}, label: {
						Text("Send")
						Image(systemName: "paperplane.fill")
					})
					Divider()
					Button(role: .destructive, action: {}, label: {
						Text("Delete")
						Image(systemName: "trash")
					})

				})
			} preview: {
				preview(fillColor)
			}

	}

	func preview(_ fillColor: Color) -> some View {
		RoundedRectangle(cornerRadius: 12)
			.fill(fillColor.opacity(0.9))
			.frame(width: 250, height: 380)
			.overlay(alignment: .bottom) {
				Rectangle()
					.fill(Color.black.opacity(0.3))
					.containerRelativeFrame([.horizontal], alignment: .leading)
					.frame(height: 70)
					.overlay {
						VStack(alignment: .leading) {
							Capsule()
								.fill(.black.opacity(0.1))
							Capsule()
								.fill(.black.opacity(0.1))
								.frame(width: 70)

						}
						.padding()

					}
			}
	}
}

extension Color {
	static var random: Color {
		Color(
			red: .random(in: 0...1),
			green: .random(in: 0...1),
			blue: .random(in: 0...1)
		)
	}
}
#Preview {
	ContextMenu()
}
