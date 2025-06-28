//
//  StoriesPreview.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import SwiftUI

struct StoriesPreview: View {
    let topics: [Topic]
    let onTapTopic: (Topic) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(topics) { topic in
                    Image(topic.previewName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 92, height: 140)
                        .clipShape(.rect(cornerRadius: 16))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.blue, lineWidth: 4)
                                .opacity(topic.isViewed ? 0 : 1)

                            VStack {
                                Spacer()

                                Text(topic.title)
                                    .font(.regular12)
                                    .lineLimit(3)
                                    .foregroundStyle(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 12)
                        }
                        .onTapGesture {
                            onTapTopic(topic)
                        }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 24)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    let topics: [Topic] = [.topic1, .topic2, .topic3, .topic4]

    StoriesPreview(topics: topics) {
        print("Tapped on topic: \($0.title)")
    }
}
