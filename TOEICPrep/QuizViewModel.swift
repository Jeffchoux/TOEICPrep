//
//  QuizViewModel.swift
//  TOEICPrep
//
//  ViewModel pour gerer la logique du quiz - Objectif 850 points
//

import Foundation
import SwiftUI

@Observable
class QuizViewModel {
    var questions: [Question] = []
    var currentQuestionIndex: Int = 0
    var selectedAnswers: [Int?] = []
    var score: Int = 0
    var isQuizCompleted: Bool = false
    var showResults: Bool = false
    var selectedSection: QuestionSection?

    private let questionsPerQuiz = 20

    init(selectedSection: QuestionSection? = nil) {
        self.selectedSection = selectedSection
        loadQuestions()
    }

    func loadQuestions() {
        let availableQuestions = QuestionBank.questions(for: selectedSection)
        questions = Array(availableQuestions.prefix(questionsPerQuiz))
        selectedAnswers = Array(repeating: nil, count: questions.count)
        currentQuestionIndex = 0
        score = 0
        isQuizCompleted = false
        showResults = false
    }

    var currentQuestion: Question? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }

    var progress: Double {
        guard !questions.isEmpty else { return 0 }
        return Double(currentQuestionIndex + 1) / Double(questions.count)
    }

    func selectAnswer(_ answerIndex: Int) {
        selectedAnswers[currentQuestionIndex] = answerIndex
    }

    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            finishQuiz()
        }
    }

    func previousQuestion() {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
        }
    }

    func finishQuiz() {
        calculateScore()
        isQuizCompleted = true
        showResults = true
        saveProgress()
    }

    private func calculateScore() {
        score = 0
        for (index, answer) in selectedAnswers.enumerated() {
            if let answer = answer, answer == questions[index].correctAnswer {
                score += 1
            }
        }
    }

    private func saveProgress() {
        let defaults = UserDefaults.standard

        // Incrementer le nombre de quiz
        var totalQuizzes = defaults.integer(forKey: "totalQuizzesTaken")
        totalQuizzes += 1
        defaults.set(totalQuizzes, forKey: "totalQuizzesTaken")

        // Calculer la nouvelle moyenne
        let previousAverage = defaults.double(forKey: "averageScore")
        let newAverage = ((previousAverage * Double(totalQuizzes - 1)) + Double(scorePercentage)) / Double(totalQuizzes)
        defaults.set(newAverage, forKey: "averageScore")

        // Mettre a jour le meilleur score
        let currentBest = defaults.integer(forKey: "bestScore")
        if scorePercentage > currentBest {
            defaults.set(scorePercentage, forKey: "bestScore")
        }

        // Sauvegarder les scores par section
        if let section = selectedSection {
            let sectionKey = "score_\(section.rawValue)"
            var sectionScores = defaults.array(forKey: sectionKey) as? [Int] ?? []
            sectionScores.append(scorePercentage)
            defaults.set(sectionScores, forKey: sectionKey)
        }
    }

    func restartQuiz() {
        loadQuestions()
    }

    var scorePercentage: Int {
        guard !questions.isEmpty else { return 0 }
        return Int((Double(score) / Double(questions.count)) * 100)
    }

    // Estimation du score TOEIC basee sur le pourcentage
    var estimatedTOEICScore: Int {
        // Score TOEIC va de 10 a 990
        // On estime: 100% = ~950, 90% = ~850, 80% = ~750, etc.
        let baseScore = 10
        let maxAdditional = 940 // 950 - 10
        return baseScore + Int(Double(scorePercentage) / 100.0 * Double(maxAdditional))
    }

    var targetScore: Int { 850 }

    var isTargetReached: Bool {
        estimatedTOEICScore >= targetScore
    }

    var selectedAnswer: Int? {
        selectedAnswers[currentQuestionIndex]
    }

    func isAnswerCorrect(at index: Int) -> Bool? {
        guard let answer = selectedAnswers[index] else { return nil }
        return answer == questions[index].correctAnswer
    }

    // Statistiques par difficulte
    var scoreByDifficulty: [QuestionDifficulty: (correct: Int, total: Int)] {
        var result: [QuestionDifficulty: (correct: Int, total: Int)] = [:]

        for difficulty in QuestionDifficulty.allCases {
            let questionsOfDifficulty = questions.enumerated().filter { $0.element.difficulty == difficulty }
            let correct = questionsOfDifficulty.filter { index, _ in
                if let answer = selectedAnswers[index] {
                    return answer == questions[index].correctAnswer
                }
                return false
            }.count
            result[difficulty] = (correct, questionsOfDifficulty.count)
        }

        return result
    }

    // Statistiques par section
    var scoreBySection: [QuestionSection: (correct: Int, total: Int)] {
        var result: [QuestionSection: (correct: Int, total: Int)] = [:]

        for section in QuestionSection.allCases {
            let questionsOfSection = questions.enumerated().filter { $0.element.section == section }
            let correct = questionsOfSection.filter { index, _ in
                if let answer = selectedAnswers[index] {
                    return answer == questions[index].correctAnswer
                }
                return false
            }.count
            result[section] = (correct, questionsOfSection.count)
        }

        return result
    }
}
