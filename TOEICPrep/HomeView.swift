//
//  HomeView.swift
//  TOEICPrep
//
//  Vue d'accueil de l'application - Objectif 850 points
//

import SwiftUI

struct HomeView: View {
    @State private var showQuiz = false
    @State private var selectedSection: QuestionSection? = nil
    @AppStorage("totalQuizzesTaken") private var totalQuizzesTaken = 0
    @AppStorage("averageScore") private var averageScore = 0.0
    @AppStorage("bestScore") private var bestScore = 0

    private let targetScore = 850

    var body: some View {
        NavigationStack {
            ZStack {
                // Arriere-plan avec degrade
                LinearGradient(
                    colors: [Color.blue.opacity(0.7), Color.indigo.opacity(0.5)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 25) {
                        // Logo et titre
                        VStack(spacing: 12) {
                            Image(systemName: "target")
                                .font(.system(size: 70))
                                .foregroundColor(.white)

                            Text("TOEIC Prep")
                                .font(.system(size: 42, weight: .bold))
                                .foregroundColor(.white)

                            Text("Objectif : \(targetScore) points")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.yellow)

                            Text("Niveau B2+ / C1")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding(.top, 40)

                        // Statistiques de progression
                        if totalQuizzesTaken > 0 {
                            ProgressStatsCard(
                                quizzesTaken: totalQuizzesTaken,
                                averageScore: averageScore,
                                bestScore: bestScore,
                                targetScore: targetScore
                            )
                            .padding(.horizontal, 20)
                        }

                        // Selection de section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Choisir une section")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    SectionButton(
                                        section: nil,
                                        title: "Toutes",
                                        icon: "square.grid.2x2.fill",
                                        isSelected: selectedSection == nil,
                                        action: { selectedSection = nil }
                                    )

                                    ForEach(QuestionSection.allCases, id: \.self) { section in
                                        SectionButton(
                                            section: section,
                                            title: section.shortName,
                                            icon: section.icon,
                                            isSelected: selectedSection == section,
                                            action: { selectedSection = section }
                                        )
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }

                        // Informations sur le quiz
                        VStack(spacing: 12) {
                            InfoCard(icon: "list.bullet.clipboard", text: "20 questions niveau 850+")
                            InfoCard(icon: "brain.head.profile", text: "Grammar, Vocabulary, Reading")
                            InfoCard(icon: "chart.line.uptrend.xyaxis", text: "Suivi de progression")
                            InfoCard(icon: "lightbulb.fill", text: "Explications detaillees")
                        }
                        .padding(.horizontal, 20)

                        // Bouton de demarrage
                        Button(action: {
                            showQuiz = true
                        }) {
                            HStack {
                                Text("Commencer l'entrainement")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.title3)
                            }
                            .foregroundColor(.indigo)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    }
                }
            }
            .navigationDestination(isPresented: $showQuiz) {
                QuizView(selectedSection: selectedSection)
            }
        }
    }
}

struct ProgressStatsCard: View {
    let quizzesTaken: Int
    let averageScore: Double
    let bestScore: Int
    let targetScore: Int

    private var estimatedTOEICScore: Int {
        Int(averageScore * 9.9) // 100% = ~990 points
    }

    private var progressToTarget: Double {
        min(Double(estimatedTOEICScore) / Double(targetScore), 1.0)
    }

    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Votre progression")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Text("\(quizzesTaken) quiz")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            // Barre de progression vers 850
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Score estime : \(estimatedTOEICScore)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(estimatedTOEICScore >= targetScore ? .green : .blue)

                    Text("/ \(targetScore)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }

                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 12)
                            .cornerRadius(6)

                        Rectangle()
                            .fill(estimatedTOEICScore >= targetScore ? Color.green : Color.blue)
                            .frame(width: geometry.size.width * progressToTarget, height: 12)
                            .cornerRadius(6)
                    }
                }
                .frame(height: 12)
            }

            HStack {
                VStack(alignment: .leading) {
                    Text("Moyenne")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(Int(averageScore))%")
                        .font(.headline)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text("Meilleur")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(bestScore)%")
                        .font(.headline)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct SectionButton: View {
    let section: QuestionSection?
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
            }
            .foregroundColor(isSelected ? .white : .white.opacity(0.8))
            .frame(width: 80, height: 70)
            .background(isSelected ? Color.white.opacity(0.3) : Color.white.opacity(0.1))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.white : Color.clear, lineWidth: 2)
            )
        }
    }
}

struct InfoCard: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 40)
            
            Text(text)
                .font(.body)
                .foregroundColor(.white)
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
    }
}

#Preview {
    HomeView()
}
