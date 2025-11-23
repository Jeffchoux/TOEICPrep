//
//  ResultView.swift
//  TOEICPrep
//
//  Vue affichant les resultats du quiz - Objectif 850 points
//

import SwiftUI

struct ResultView: View {
    let viewModel: QuizViewModel
    @Environment(\.dismiss) private var dismiss

    private let targetScore = 850

    var body: some View {
        ZStack {
            // Arriere-plan
            LinearGradient(
                colors: scoreColor.map { $0.opacity(0.3) },
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 25) {
                    // En-tete avec score TOEIC estime
                    VStack(spacing: 15) {
                        Image(systemName: scoreIcon)
                            .font(.system(size: 70))
                            .foregroundColor(scoreColor[0])

                        Text(scoreMessage)
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        // Score TOEIC estime
                        VStack(spacing: 8) {
                            Text("Score TOEIC estime")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text("\(viewModel.estimatedTOEICScore)")
                                    .font(.system(size: 60, weight: .bold))
                                    .foregroundColor(viewModel.isTargetReached ? .green : scoreColor[0])

                                Text("/ 990")
                                    .font(.title2)
                                    .foregroundColor(.secondary)
                            }

                            // Indicateur objectif 850
                            HStack {
                                Image(systemName: viewModel.isTargetReached ? "checkmark.seal.fill" : "target")
                                    .foregroundColor(viewModel.isTargetReached ? .green : .orange)
                                Text(viewModel.isTargetReached ? "Objectif 850 atteint !" : "Objectif : 850 points")
                                    .font(.headline)
                                    .foregroundColor(viewModel.isTargetReached ? .green : .orange)
                            }
                            .padding(.top, 5)
                        }

                        // Cercle de score (pourcentage)
                        ZStack {
                            Circle()
                                .stroke(Color.gray.opacity(0.2), lineWidth: 12)
                                .frame(width: 150, height: 150)

                            Circle()
                                .trim(from: 0, to: Double(viewModel.scorePercentage) / 100)
                                .stroke(scoreColor[0], style: StrokeStyle(lineWidth: 12, lineCap: .round))
                                .frame(width: 150, height: 150)
                                .rotationEffect(.degrees(-90))
                                .animation(.easeInOut(duration: 1), value: viewModel.scorePercentage)

                            VStack {
                                Text("\(viewModel.scorePercentage)%")
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(scoreColor[0])

                                Text("\(viewModel.score)/\(viewModel.questions.count)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.top, 30)

                    // Statistiques generales
                    VStack(spacing: 12) {
                        StatCard(
                            icon: "checkmark.circle.fill",
                            title: "Bonnes reponses",
                            value: "\(viewModel.score)",
                            color: .green
                        )

                        StatCard(
                            icon: "xmark.circle.fill",
                            title: "Mauvaises reponses",
                            value: "\(viewModel.questions.count - viewModel.score)",
                            color: .red
                        )
                    }
                    .padding(.horizontal)

                    // Statistiques par difficulte
                    DifficultyStatsView(scoreByDifficulty: viewModel.scoreByDifficulty)
                        .padding(.horizontal)

                    // Statistiques par section
                    SectionStatsView(scoreBySection: viewModel.scoreBySection)
                        .padding(.horizontal)
                    
                    // Details des reponses
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Details des reponses")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)

                        ForEach(viewModel.questions.indices, id: \.self) { index in
                            QuestionResultCard(
                                question: viewModel.questions[index],
                                questionNumber: index + 1,
                                userAnswer: viewModel.selectedAnswers[index],
                                isCorrect: viewModel.isAnswerCorrect(at: index)
                            )
                        }
                    }
                    .padding(.vertical)

                    // Boutons d'action
                    VStack(spacing: 15) {
                        Button(action: {
                            viewModel.restartQuiz()
                            dismiss()
                        }) {
                            HStack {
                                Image(systemName: "arrow.clockwise")
                                Text("Nouvel entrainement")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                        }

                        Button(action: {
                            dismiss()
                        }) {
                            HStack {
                                Image(systemName: "house.fill")
                                Text("Retour a l'accueil")
                            }
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // Proprietes calculees pour l'affichage
    private var scoreColor: [Color] {
        switch viewModel.estimatedTOEICScore {
        case 850...990: return [.green]
        case 750..<850: return [.blue]
        case 600..<750: return [.orange]
        default: return [.red]
        }
    }

    private var scoreIcon: String {
        switch viewModel.estimatedTOEICScore {
        case 850...990: return "star.fill"
        case 750..<850: return "hand.thumbsup.fill"
        case 600..<750: return "flame.fill"
        default: return "book.fill"
        }
    }

    private var scoreMessage: String {
        switch viewModel.estimatedTOEICScore {
        case 850...990: return "Objectif atteint !"
        case 750..<850: return "Presque !"
        case 600..<750: return "Progresse !"
        default: return "Continue !"
        }
    }
}

// MARK: - Difficulty Stats View
struct DifficultyStatsView: View {
    let scoreByDifficulty: [QuestionDifficulty: (correct: Int, total: Int)]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Par niveau de difficulte")
                .font(.headline)
                .foregroundColor(.primary)

            ForEach(QuestionDifficulty.allCases, id: \.self) { difficulty in
                if let stats = scoreByDifficulty[difficulty], stats.total > 0 {
                    DifficultyStatRow(
                        difficulty: difficulty,
                        correct: stats.correct,
                        total: stats.total
                    )
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct DifficultyStatRow: View {
    let difficulty: QuestionDifficulty
    let correct: Int
    let total: Int

    private var percentage: Double {
        guard total > 0 else { return 0 }
        return Double(correct) / Double(total)
    }

    private var color: Color {
        switch difficulty {
        case .intermediate: return .orange
        case .upperIntermediate: return .blue
        case .advanced: return .purple
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(difficulty.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.primary)

                Spacer()

                Text("\(correct)/\(total)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(color)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 8)
                        .cornerRadius(4)

                    Rectangle()
                        .fill(color)
                        .frame(width: geometry.size.width * percentage, height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
        }
    }
}

// MARK: - Section Stats View
struct SectionStatsView: View {
    let scoreBySection: [QuestionSection: (correct: Int, total: Int)]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Par section")
                .font(.headline)
                .foregroundColor(.primary)

            ForEach(QuestionSection.allCases, id: \.self) { section in
                if let stats = scoreBySection[section], stats.total > 0 {
                    SectionStatRow(
                        section: section,
                        correct: stats.correct,
                        total: stats.total
                    )
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct SectionStatRow: View {
    let section: QuestionSection
    let correct: Int
    let total: Int

    private var percentage: Double {
        guard total > 0 else { return 0 }
        return Double(correct) / Double(total)
    }

    private var color: Color {
        switch section {
        case .grammar: return .blue
        case .vocabulary: return .green
        case .reading: return .orange
        case .businessEnglish: return .purple
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Image(systemName: section.icon)
                    .foregroundColor(color)
                    .frame(width: 20)

                Text(section.rawValue)
                    .font(.subheadline)
                    .foregroundColor(.primary)

                Spacer()

                Text("\(correct)/\(total)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(color)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 8)
                        .cornerRadius(4)

                    Rectangle()
                        .fill(color)
                        .frame(width: geometry.size.width * percentage, height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
        }
    }
}

struct StatCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct QuestionResultCard: View {
    let question: Question
    let questionNumber: Int
    let userAnswer: Int?
    let isCorrect: Bool?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // En-tête
            HStack {
                Text("Question \(questionNumber)")
                    .font(.headline)
                
                Spacer()
                
                if let isCorrect = isCorrect {
                    Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(isCorrect ? .green : .red)
                        .font(.title3)
                }
            }
            
            // Question
            Text(question.text)
                .font(.body)
                .foregroundColor(.primary)
            
            // Réponse de l'utilisateur
            if let userAnswer = userAnswer {
                HStack {
                    Text("Votre réponse:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(question.options[userAnswer])
                        .font(.caption)
                        .foregroundColor(isCorrect == true ? .green : .red)
                        .fontWeight(.semibold)
                }
            }
            
            // Bonne réponse si erreur
            if isCorrect == false {
                HStack {
                    Text("Bonne réponse:")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(question.options[question.correctAnswer])
                        .font(.caption)
                        .foregroundColor(.green)
                        .fontWeight(.semibold)
                }
            }
            
            // Explication
            if !question.explanation.isEmpty && isCorrect == false {
                Text(question.explanation)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}

#Preview {
    let viewModel = QuizViewModel()
    viewModel.finishQuiz()
    return NavigationStack {
        ResultView(viewModel: viewModel)
    }
}
