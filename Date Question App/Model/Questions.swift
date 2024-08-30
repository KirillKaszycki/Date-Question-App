//
//  Questions.swift
//  Date Question App
//
//  Created by Кирилл Кашицкий on 30.08.2024.
//

import Foundation

enum Questions {
    static let acquaintanceQuestions: [String] = [
        "Какое твоё любимое занятие в свободное время?",
        "Как ты проводишь выходные?",
        "Какой у тебя любимый фильм?"
    ]

    static let romanticQuestions: [String] = [
        "Что для тебя означает любовь?",
        "Какой самый романтичный поступок ты совершал?",
        "Как ты представляешь идеальное свидание?"
    ]

    static let mixedQuestions: [String] = acquaintanceQuestions + romanticQuestions
}



