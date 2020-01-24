//
//  CreateQuestionPoolInteractorTests.swift
//  BusinessLogic
//
//  Created by Vladyslav Panevnyk on 24.01.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import BusinessLogic

final class CreateQuestionPoolInteractorTests: XCTestCase {
    // MARK: - Mocks
    private let output = CreateQuestionPoolInteractorOutputMock()
    private let createPoolDBMock = CreateQuestionPoolDBBoundaryMock()

    // MARK: - Tests create questions pool output
    func test_createQuestionPoolOutput_withNoQuestions_poolCreationFailure() {
        makeSUT().createQuestionPool()
        XCTAssertTrue(output.isPoolCreationFailure)
    }

    func test_createQuestionPoolOutput_withOneQuestion_poolCreatedSuccessfuly() {
        let sut = makeSUT()

        sut.addQuestion(Question(questionTitle: "", answerType: .boolean))
        sut.createQuestionPool()

        XCTAssertTrue(output.isPoolDidCreateSuccessfuly)
    }

    // MARK: - Tests create questions pool save to DB
    func test_createQuestionPoolDB_withNoQuestions_poolCreationFailure() {
        makeSUT().createQuestionPool()
        XCTAssertNil(createPoolDBMock.questionPool)
    }

    func test_createQuestionPoolDB_withTwoQuestions_poolCreatedSuccessfuly() {
        let sut = makeSUT()

        sut.addQuestion(Question(questionTitle: "Test1", answerType: .boolean))
        sut.addQuestion(Question(questionTitle: "Test2", answerType: .range))
        sut.createQuestionPool()

        let questions = createPoolDBMock.questionPool?.questions
        let firstQuestion = questions?.first
        let secondQuestion = questions?.last

        XCTAssertEqual(questions?.count, 2)

        XCTAssertNotNil(firstQuestion)
        XCTAssertEqual(firstQuestion!.questionTitle, "Test1")
        XCTAssertEqual(firstQuestion!.answerType, .boolean)

        XCTAssertNotNil(secondQuestion)
        XCTAssertEqual(secondQuestion!.questionTitle, "Test2")
        XCTAssertEqual(secondQuestion!.answerType, .range)
    }

    // MARK: - Tests can create questions pool
    func test_canCreateQuestionPool_withTwoQuestions_falseResult() {
        let canCreateQuestionPool = makeSUT().canCreateQuestionPool()
        XCTAssertFalse(canCreateQuestionPool)
    }

    func test_canCreateQuestionPool_withNoQuestions_falseResult() {
        let sut = makeSUT()

        sut.addQuestion(Question(questionTitle: "Test1", answerType: .boolean))
        sut.addQuestion(Question(questionTitle: "Test2", answerType: .range))
        let canCreateQuestionPool = sut.canCreateQuestionPool()

        XCTAssertTrue(canCreateQuestionPool)
    }

    // MARK: - Helpers
    func makeSUT() -> CreateQuestionPoolInteractor {
        let sut = CreateQuestionPoolInteractor(output: output, createPoolDB: createPoolDBMock)
        return sut
    }
}

// MARK: - Mocks
private extension CreateQuestionPoolInteractorTests {
    class CreateQuestionPoolInteractorOutputMock: CreateQuestionPoolInteractorOutput {
        var isPoolDidCreateSuccessfuly = false
        var isPoolCreationFailure = false

        func poolCreatedSuccessfuly() {
            isPoolDidCreateSuccessfuly = true
        }
        func poolCreationFailure() {
            isPoolCreationFailure = true
        }
    }

    class CreateQuestionPoolDBBoundaryMock: CreateQuestionPoolDBBoundary {
        var questionPool: QuestionPool?

        func saveQuestionPool(_ questionPool: QuestionPool) {
            self.questionPool = questionPool
        }
    }
}
