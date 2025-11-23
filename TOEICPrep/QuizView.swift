//
//  QuizView.swift
//  TOEICPrep
//
//  Vue principale du quiz - Objectif 850 points
//

import SwiftUI

struct QuizView: View {
    var selectedSection: QuestionSection?
    @State private var viewModel: QuizViewModel?
    @Environment(\.dismiss) private var dismiss

    init(selectedSection: QuestionSection? = nil) {
        self.selectedSection = selectedSection
    }

    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
                .ignoresSafeArea()

            if let viewModel = viewModel {
                QuizContentView(viewModel: viewModel, dismiss: dismiss)
            } else {
                ProgressView("Chargement...")
            }
        }
        .onAppear {
            if viewModel == nil {
                viewModel = QuizViewModel(selectedSection: selectedSection)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                        Text("Quitter")
                    }
                    .foregroundColor(.red)
                }
            }
        }
        .navigationDestination(isPresented: Binding(
            get: { viewModel?.showResults ?? false },
            set: { viewModel?.showResults = $0 }
        )) {
            if let viewModel = viewModel {
                ResultView(viewModel: viewModel)
            }
        }
    }
}

struct QuizContentView: View {
    @Bindable var viewModel: QuizViewModel
    let dismiss: DismissAction

    var body: some View {
        VStack(spacing: 0) {
            // Barre de progression
            ProgressBar(progress: viewModel.progress)
                .padding(.horizontal)
                .padding(.top)

            if let question = viewModel.currentQuestion {
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        // En-tete de question
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Question \(viewModel.currentQuestionIndex + 1)/\(viewModel.questions.count)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                Spacer()

                                // Badge de difficulte
                                DifficultyBadge(difficulty: question.difficulty)
                            }

                            HStack(spacing: 8) {
                                Text(question.section.rawValue)
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue)
                                    .cornerRadius(8)

                                Text(question.partType.shortName)
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.indigo)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                            
                        // Question
                        Text(question.text)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.horizontal)

                        // Options de reponse
                        VStack(spacing: 12) {
                            ForEach(question.options.indices, id: \.self) { index in
                                AnswerButton(
                                    text: question.options[index],
                                    index: index,
                                    isSelected: viewModel.selectedAnswer == index,
                                    action: {
                                        viewModel.selectAnswer(index)
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                // Boutons de navigation
                HStack(spacing: 15) {
                    if viewModel.currentQuestionIndex > 0 {
                        Button(action: {
                            viewModel.previousQuestion()
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Precedent")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.primary)
                            .cornerRadius(12)
                        }
                    }

                    Button(action: {
                        if viewModel.currentQuestionIndex == viewModel.questions.count - 1 {
                            viewModel.finishQuiz()
                        } else {
                            viewModel.nextQuestion()
                        }
                    }) {
                        HStack {
                            Text(viewModel.currentQuestionIndex == viewModel.questions.count - 1 ? "Terminer" : "Suivant")
                            Image(systemName: viewModel.currentQuestionIndex == viewModel.questions.count - 1 ? "checkmark.circle.fill" : "chevron.right")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.selectedAnswer != nil ? Color.blue : Color.gray.opacity(0.3))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(viewModel.selectedAnswer == nil)
                }
                .padding()
            }
        }
    }
}

struct DifficultyBadge: View {
    let difficulty: QuestionDifficulty

    private var color: Color {
        switch difficulty {
        case .intermediate: return .orange
        case .upperIntermediate: return .blue
        case .advanced: return .purple
        }
    }

    var body: some View {
        Text(difficulty.targetScore)
            .font(.caption2)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color)
            .cornerRadius(6)
    }
}

struct ProgressBar: View {
    let progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 8)
                    .cornerRadius(4)
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: geometry.size.width * progress, height: 8)
                    .cornerRadius(4)
                    .animation(.easeInOut, value: progress)
            }
        }
        .frame(height: 8)
    }
}

struct AnswerButton: View {
    let text: String
    let index: Int
    let isSelected: Bool
    let action: () -> Void
    
    private let letters = ["A", "B", "C", "D"]
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                // Lettre de l'option
                Text(letters[index])
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(isSelected ? .white : .blue)
                    .frame(width: 40, height: 40)
                    .background(isSelected ? Color.blue : Color.blue.opacity(0.1))
                    .cornerRadius(10)
                
                // Texte de la réponse
                Text(text)
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                // Icône de sélection
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title3)
                }
            }
            .padding()
            .background(isSelected ? Color.blue.opacity(0.1) : Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue : Color.gray.opacity(0.2), lineWidth: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NavigationStack {
        QuizView()
    }
}
