//
//  Topic.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 04.07.2025.
//

import Foundation

struct Topic: Identifiable {
    let id: UUID
    let previewName: String
    let stories: [Story]
    let title: String
    let isViewed: Bool
    
    
    init(id: UUID = UUID(), previewName: String, stories: [Story], isViewed: Bool = false) {
        self.id = id
        self.previewName = previewName
        self.stories = stories
        self.title = stories.first?.title ?? "Без названия"
        self.isViewed = isViewed
    }
    
    func markAsViewed() -> Topic {
        Topic(
            id: self.id,
            previewName: self.previewName,
            stories: self.stories,
            isViewed: true
        )
    }
}
