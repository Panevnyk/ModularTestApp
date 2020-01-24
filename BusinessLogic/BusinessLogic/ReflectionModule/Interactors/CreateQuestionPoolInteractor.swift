//
//  CreateQuestionPoolInteractor.swift
//  BusinessLogic
//
//  Created by Vladyslav Panevnyk on 24.01.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

public protocol CreateQuestionPoolInteractorInput {
    func addQuestion(_ question: Question)
    func createQuestionPool()
    func canCreateQuestionPool() -> Bool
}

public protocol CreateQuestionPoolInteractorOutput {
    func poolCreatedSuccessfuly()
    func poolCreationFailure()
}

public protocol CreateQuestionPoolDBBoundary {
    func saveQuestionPool(_ questionPool: QuestionPool)
}

final public class CreateQuestionPoolInteractor: CreateQuestionPoolInteractorInput {
    // MARK: - Properties
    private let output: CreateQuestionPoolInteractorOutput
    private let createPoolDB: CreateQuestionPoolDBBoundary

    private var questions: [Question] = []

    // MARK: - Inits
    public init(output: CreateQuestionPoolInteractorOutput, createPoolDB: CreateQuestionPoolDBBoundary) {
        self.output = output
        self.createPoolDB = createPoolDB
    }
}

// MARK: - Public
public extension CreateQuestionPoolInteractor {
    func addQuestion(_ question: Question) {
        questions.append(question)
    }

    func createQuestionPool() {
        guard canCreateQuestionPool() else {
            output.poolCreationFailure()
            return
        }

        let questionPool = QuestionPool(questions: questions)
        createPoolDB.saveQuestionPool(questionPool)
        output.poolCreatedSuccessfuly()
    }

    func canCreateQuestionPool() -> Bool {
        return !questions.isEmpty
    }
}
