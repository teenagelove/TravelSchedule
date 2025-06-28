//
//  Story.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 28.06.2025.
//

import Foundation

struct Story: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let description: String
}

struct Topic: Identifiable {
    let id = UUID()
    let previewName: String
    let stories: [Story]
    let title: String
    let isViewed: Bool
    
    
    init(previewName: String, stories: [Story], isViewed: Bool = false) {
        self.previewName = previewName
        self.stories = stories
        self.title = stories.first?.title ?? "Без названия"
        self.isViewed = isViewed
    }
    
    func markAsViewed() -> Topic {
        Topic(
            previewName: self.previewName,
            stories: self.stories,
            isViewed: true
        )
    }
    
    static let topic1 = Topic(
        previewName: "topic1",
        stories: [
            Story(title: "Машинист на посту", imageName: "story1", description: "Отправляемся в путь вместе с машинистом, который управляет поездом с уверенностью и точностью. Его рабочее место — кабина, где начинается каждое путешествие."),
            Story(title: "Жизнь на рельсах", imageName: "story2", description: "Знакомьтесь с героем, который каждый день следит за безопасностью железнодорожных путей. Его работа — гарантия вашей поездки.")
        ]
    )
    
    static let topic2 = Topic(
        previewName: "topic2",
        stories: [
            Story(title: "С заботой о пассажирах", imageName: "story3", description: "Проводница встречает пассажиров с улыбкой, помогает разместиться и следит за порядком в вагоне. Она — душа поезда."),
            Story(title: "Проводница в пути", imageName: "story4", description: "День из жизни проводницы — от раннего утра до поздней ночи. Забота, ответственность и дорога, которая никогда не заканчивается.")
        ]
    )
    
    static let topic3 = Topic(
        previewName: "topic3",
        stories: [
            Story(title: "В ожидании остановки", imageName: "story5", description: "Пассажиры затаили дыхание в ожидании следующей станции. Каждый ждёт чего-то своего."),
            Story(title: "Когда поезд стоит", imageName: "story6", description: "Важное решение — сотрудник железной дороги экстренно останавливает поезд. Что произошло?")
        ]
    )
    
    static let topic4 = Topic(
        previewName: "topic4",
        stories: [
            Story(title: "Тишина в вагоне", imageName: "story7", description: "Пустой вагон — загадка и спокойствие. Что осталось за кадром?"),
            Story(title: "Пустой, но полный историй", imageName: "story8", description: "Хотя в вагоне никого нет, он хранит в себе множество воспоминаний и ожиданий.")
        ]
    )
    
    static let topic5 = Topic(
        previewName: "topic5",
        stories: [
            Story(title: "Сквозь снег и метель", imageName: "story9", description: "Поезд мчится по заснеженной равнине, прокладывая путь в белом безмолвии."),
            Story(title: "Белая дорога", imageName: "story10", description: "Заснеженный экспресс: путь сквозь вьюгу, где каждый кадр словно открытка.")
        ]
    )
    
    static let topic6 = Topic(
        previewName: "topic6",
        stories: [
            Story(title: "Поезд в сердце джунглей", imageName: "story11", description: "Гуманитарная миссия в движении — поезд пробирается сквозь густую зелень и доставляет помощь туда, где она нужна."),
            Story(title: "Поезд жизни", imageName: "story12", description: "В Африке поезд — это не просто транспорт, это надежда. История о людях и помощи, которая меняет судьбы.")
        ]
    )
    
    static let topic7 = Topic(
        previewName: "topic7",
        stories: [
            Story(title: "Бабушкины дары", imageName: "story13", description: "Огурцы, помидоры и теплота — всё, что везёт с собой бабушка в поезде, наполнено заботой."),
            Story(title: "Вагон урожая", imageName: "story14", description: "Что, если тыква почти с вагон, а огурцы — как бананы? История про невероятный урожай в поезде.")
        ]
    )
    
    static let topic8 = Topic(
        previewName: "topic8",
        stories: [
            Story(title: "Баян звучит в пути", imageName: "story15", description: "В поезде звучит музыка — пассажир играет на баяне, наполняя вагон атмосферой уюта и веселья."),
            Story(title: "Поезд под баян", imageName: "story16", description: "Повторение — мать вдохновения. Музыка и ритм дороги с баяном в главной роли.")
        ]
    )
    
    static let topic9 = Topic(
        previewName: "topic9",
        stories: [
            Story(title: "Читают вдвоём", imageName: "story17", description: "Бабушка и дедушка в поезде делят тишину и страницы книги. Простое счастье в пути."),
            Story(title: "Мир в книге", imageName: "story18", description: "Молодая девушка в поезде уносится мыслями в другую реальность, листая страницы романа.")
        ]
    )
    
    static let allTopics: [Topic] = [
        topic1, topic2, topic3, topic4, topic5,
        topic6, topic7, topic8, topic9
    ]
}
