//
//  ReflectionEntity.swift
//  BusinessLogic
//
//  Created by Vladyslav Panevnyk on 24.01.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

public struct QuestionPool {
    public var questions: [Question]
}

extension QuestionPool: Equatable {
    public static func == (lhs: QuestionPool, rhs: QuestionPool) -> Bool {
        return lhs.questions == rhs.questions
    }
}

public struct Question {
    public var questionTitle: String
    public var answerType: AnswerType
}

extension Question: Equatable {
    public static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.questionTitle == rhs.questionTitle
            && lhs.answerType == rhs.answerType
    }
}

public enum AnswerType: String {
    case boolean
    case counting
    case range
    case time
    case description
}

//public struct Reflection {
//    public var question: Question
//    public var date: Date
//    public var answerType: AnswerType
//}

//public struct ReflectionPool {
//    public var questions: [Question]
//    public var reflections: [Reflection]
//}

//public enum ReflectionAnswerType {
//    case boolean(Bool)
//    case counting(Int)
//    case range(Int)
//    case time(Date)
//    case description(String)
//}
