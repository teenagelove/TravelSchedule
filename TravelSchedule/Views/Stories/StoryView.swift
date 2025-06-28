//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import SwiftUI

struct StoryView: View {
    let story: Story

    var body: some View {
        Color.black
            .ignoresSafeArea()
            .overlay(
                ZStack {
                    Image(story.imageName)
                        .resizable()
                        .scaledToFill()
                        .clipShape(.rect(cornerRadius: 40))
                        .padding(.top, 7)
                        .padding(.bottom, 17)

                    VStack {
                        Spacer()

                        VStack(alignment: .leading, spacing: 10) {
                            Text(story.title)
                                .font(.bold34)
                                .foregroundColor(.white)
                                .lineLimit(2)

                            Text(story.description)
                                .font(.regular20)
                                .lineLimit(3)
                                .foregroundColor(.white)
                        }
                        .padding(
                            .init(top: 0, leading: 16, bottom: 57, trailing: 16)
                        )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            )
    }
}

#Preview {
    let story = Topic.topic3.stories[0]

    StoryView(story: story)
}
