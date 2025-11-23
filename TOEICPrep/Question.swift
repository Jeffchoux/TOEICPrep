//
//  Question.swift
//  TOEICPrep
//
//  Modele de donnees pour les questions TOEIC - Niveau 850+
//  Format actualise TOEIC 2024: Part 5 (30 questions), Part 6 (16 questions), Part 7
//

import Foundation
import SwiftData

@Model
class Question {
    var id: UUID
    var text: String
    var options: [String]
    var correctAnswer: Int
    var section: QuestionSection
    var explanation: String
    var difficulty: QuestionDifficulty
    var partType: TOEICPart

    init(
        text: String,
        options: [String],
        correctAnswer: Int,
        section: QuestionSection,
        explanation: String = "",
        difficulty: QuestionDifficulty = .intermediate,
        partType: TOEICPart = .part5
    ) {
        self.id = UUID()
        self.text = text
        self.options = options
        self.correctAnswer = correctAnswer
        self.section = section
        self.explanation = explanation
        self.difficulty = difficulty
        self.partType = partType
    }
}

enum QuestionSection: String, Codable, CaseIterable {
    case grammar = "Grammar"
    case vocabulary = "Vocabulary"
    case reading = "Reading"
    case businessEnglish = "Business English"

    var shortName: String {
        switch self {
        case .grammar: return "Grammar"
        case .vocabulary: return "Vocab"
        case .reading: return "Reading"
        case .businessEnglish: return "Business"
        }
    }

    var icon: String {
        switch self {
        case .grammar: return "text.book.closed.fill"
        case .vocabulary: return "character.book.closed.fill"
        case .reading: return "doc.text.fill"
        case .businessEnglish: return "briefcase.fill"
        }
    }
}

enum QuestionDifficulty: String, Codable, CaseIterable {
    case intermediate = "Intermediate"
    case upperIntermediate = "Upper-Intermediate"
    case advanced = "Advanced"

    var color: String {
        switch self {
        case .intermediate: return "orange"
        case .upperIntermediate: return "blue"
        case .advanced: return "purple"
        }
    }

    var targetScore: String {
        switch self {
        case .intermediate: return "600-750"
        case .upperIntermediate: return "750-850"
        case .advanced: return "850+"
        }
    }
}

enum TOEICPart: String, Codable, CaseIterable {
    case part5 = "Part 5 - Incomplete Sentences"
    case part6 = "Part 6 - Text Completion"
    case part7 = "Part 7 - Reading Comprehension"

    var shortName: String {
        switch self {
        case .part5: return "Part 5"
        case .part6: return "Part 6"
        case .part7: return "Part 7"
        }
    }
}

// MARK: - Question Bank TOEIC Niveau 850+
// Reponses melangees - positions variees (0, 1, 2, 3)

class QuestionBank {

    // MARK: - VERB TENSES (Cle pour 850+)
    static let verbTenseQuestions: [Question] = [
        Question(
            text: "The company _____ its new product line by the end of next quarter.",
            options: ["launched", "will have launched", "has launched", "is launching"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "Future Perfect: 'will have + past participle' pour une action qui sera completee avant un moment futur ('by the end of next quarter').",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "She _____ for the company since 2015.",
            options: ["works", "worked", "has worked", "is working"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "Present Perfect avec 'since' + date precise. 'Has worked' indique une action commencee dans le passe et qui continue.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "By the time the CEO arrived, the board members _____ the proposal.",
            options: ["already discussed", "had already discussed", "have already discussed", "were discussing"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "Past Perfect: 'had + past participle' pour une action completee avant une autre action passee.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "The marketing team _____ on the new campaign when the budget was cut.",
            options: ["worked", "works", "was working", "has worked"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "Past Continuous: action en cours dans le passe interrompue par une autre action ('when the budget was cut').",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "Once the contract _____, we will begin production immediately.",
            options: ["is signed", "will be signed", "signed", "has signed"],
            correctAnswer: 0,
            section: .grammar,
            explanation: "Apres 'once' (une fois que), on utilise le present simple pour exprimer le futur, pas 'will'.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "The report indicates that consumer spending _____ significantly last quarter.",
            options: ["increases", "increased", "has increased", "will increase"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Last quarter' indique un moment passe precis, donc on utilise le Past Simple 'increased'.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "Mr. Park _____ the Singapore office three times this year.",
            options: ["visited", "visits", "has visited", "was visiting"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "Present Perfect avec 'this year' (periode non terminee). L'action peut encore se repeter.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "If the shipment _____ on time, we would have met the deadline.",
            options: ["arrived", "had arrived", "arrives", "would arrive"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "Third Conditional (situation irreelle dans le passe): 'If + had + past participle, would have + past participle'.",
            difficulty: .advanced,
            partType: .part5
        ),
    ]

    // MARK: - SUBJECT-VERB AGREEMENT
    static let subjectVerbQuestions: [Question] = [
        Question(
            text: "Neither the manager nor the employees _____ aware of the policy change.",
            options: ["is", "was", "were", "has been"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "Avec 'neither...nor', le verbe s'accorde avec le sujet le plus proche ('employees' = pluriel, donc 'were').",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "The number of applicants _____ increased dramatically this year.",
            options: ["have", "has", "are", "were"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'The number of' est singulier (le nombre), donc 'has'. Attention: 'A number of' serait pluriel.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "Each of the participants _____ required to submit a report.",
            options: ["are", "is", "were", "have been"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Each of' est toujours singulier, meme si le nom qui suit est pluriel. Donc 'is required'.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "The committee _____ its decision yesterday.",
            options: ["announce", "announces", "announced", "have announced"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "'Committee' (collectif) + 'yesterday' (passe) = Past Simple singulier 'announced'.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "Ms. Chen, along with her colleagues, _____ attending the conference in Tokyo.",
            options: ["are", "is", "were", "have been"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Along with' n'affecte pas l'accord. Le sujet principal est 'Ms. Chen' (singulier), donc 'is'.",
            difficulty: .advanced,
            partType: .part5
        ),
    ]

    // MARK: - WORD FORMS (Noun, Verb, Adjective, Adverb)
    static let wordFormQuestions: [Question] = [
        Question(
            text: "The manager praised the team for their _____ in completing the project ahead of schedule.",
            options: ["efficient", "efficiently", "efficiency", "efficiencies"],
            correctAnswer: 2,
            section: .vocabulary,
            explanation: "Apres 'their' (possessif), on a besoin d'un nom. 'Efficiency' est le nom de 'efficient'.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The instructions should be written _____.",
            options: ["clear", "clearly", "clearer", "clarity"],
            correctAnswer: 1,
            section: .vocabulary,
            explanation: "On a besoin d'un adverbe pour modifier le verbe 'written'. 'Clearly' = clairement.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The company's _____ growth strategy focuses on emerging markets.",
            options: ["aggression", "aggressive", "aggressively", "aggressed"],
            correctAnswer: 1,
            section: .vocabulary,
            explanation: "Adjectif avant le nom 'growth strategy'. 'Aggressive' modifie le nom compose.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "Customer feedback is _____ for improving our services.",
            options: ["value", "valuable", "valuably", "valuation"],
            correctAnswer: 1,
            section: .vocabulary,
            explanation: "Apres 'is', on a besoin d'un adjectif predicatif. 'Valuable' = precieux/de valeur.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The quarterly report provides a _____ analysis of market trends.",
            options: ["comprehend", "comprehensive", "comprehensively", "comprehension"],
            correctAnswer: 1,
            section: .vocabulary,
            explanation: "Adjectif avant le nom 'analysis'. 'Comprehensive' = complet, exhaustif.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "The marketing campaign was _____ successful, exceeding all targets.",
            options: ["overwhelming", "overwhelmingly", "overwhelmed", "overwhelm"],
            correctAnswer: 1,
            section: .vocabulary,
            explanation: "Adverbe pour modifier l'adjectif 'successful'. 'Overwhelmingly' = de maniere ecrasante.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "Please ensure all documents are filed _____.",
            options: ["proper", "properly", "properness", "property"],
            correctAnswer: 1,
            section: .vocabulary,
            explanation: "Adverbe pour modifier le verbe 'filed'. 'Properly' = correctement.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The candidate's qualifications are _____ suited to the position.",
            options: ["ideal", "ideally", "idealize", "idealism"],
            correctAnswer: 1,
            section: .vocabulary,
            explanation: "Adverbe pour modifier l'adjectif 'suited'. 'Ideally suited' = parfaitement adapte.",
            difficulty: .advanced,
            partType: .part5
        ),
    ]

    // MARK: - MODAL VERBS
    static let modalVerbQuestions: [Question] = [
        Question(
            text: "All employees _____ attend the safety training session tomorrow.",
            options: ["must", "might", "could", "would"],
            correctAnswer: 0,
            section: .grammar,
            explanation: "'Must' exprime une obligation forte. La formation securite est obligatoire.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The package _____ arrive by Friday, but there might be delays.",
            options: ["must", "should", "will", "can"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Should' exprime une attente/probabilite, avec une nuance d'incertitude ('might be delays').",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "You _____ have informed the client about the delay earlier.",
            options: ["should", "would", "could", "might"],
            correctAnswer: 0,
            section: .grammar,
            explanation: "'Should have + past participle' = reproche/conseil sur une action passee non realisee.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "Employees _____ request time off at least two weeks in advance.",
            options: ["might", "can", "must", "would"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "'Must' pour une regle/obligation de l'entreprise concernant les conges.",
            difficulty: .intermediate,
            partType: .part5
        ),
    ]

    // MARK: - PASSIVE VOICE
    static let passiveVoiceQuestions: [Question] = [
        Question(
            text: "The final schedule _____ to all participants next Monday.",
            options: ["will send", "will be sent", "sends", "is sending"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "Voix passive au futur: 'will be + past participle'. Le sujet 'schedule' recoit l'action.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The new policy _____ by the board last week.",
            options: ["approved", "was approved", "has approved", "approves"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "Voix passive au passe: 'was + past participle'. 'Last week' = passe.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "All invoices must _____ within 30 days of receipt.",
            options: ["process", "be processed", "processing", "to process"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Must be + past participle' = voix passive avec modal. Les factures sont traitees.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "The building _____ when we arrived at the office.",
            options: ["was being renovated", "renovated", "is renovating", "has renovated"],
            correctAnswer: 0,
            section: .grammar,
            explanation: "Past Continuous Passive: 'was being + past participle' pour une action passive en cours dans le passe.",
            difficulty: .advanced,
            partType: .part5
        ),
    ]

    // MARK: - PREPOSITIONS
    static let prepositionQuestions: [Question] = [
        Question(
            text: "The company is committed _____ reducing its carbon footprint.",
            options: ["for", "to", "with", "on"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Committed to + gerund' = engage a. Expression fixe en anglais des affaires.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "We apologize _____ any inconvenience this may have caused.",
            options: ["for", "to", "about", "with"],
            correctAnswer: 0,
            section: .grammar,
            explanation: "'Apologize for something' = s'excuser pour quelque chose. Preposition fixe.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The project was completed _____ budget and ahead of schedule.",
            options: ["over", "in", "under", "at"],
            correctAnswer: 2,
            section: .businessEnglish,
            explanation: "'Under budget' = en dessous du budget (positif). 'Over budget' = depassement.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "Ms. Torres is responsible _____ managing the entire sales team.",
            options: ["for", "to", "of", "with"],
            correctAnswer: 0,
            section: .grammar,
            explanation: "'Responsible for + gerund/noun' = responsable de. Expression fixe.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The conference will be held _____ the Grand Hotel.",
            options: ["in", "at", "on", "by"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'At' pour un lieu specifique comme un hotel, un restaurant, un batiment.",
            difficulty: .intermediate,
            partType: .part5
        ),
    ]

    // MARK: - CONJUNCTIONS & CONNECTORS
    static let conjunctionQuestions: [Question] = [
        Question(
            text: "_____ the economic downturn, the company managed to increase profits.",
            options: ["Although", "Despite", "However", "Because"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Despite' + nom/gerondif. 'Although' necessite une proposition complete avec sujet et verbe.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "The equipment must be handled with care _____ it is extremely fragile.",
            options: ["despite", "although", "as", "however"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "'As' = parce que/puisque. Introduit une raison. 'Despite/although' expriment une opposition.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "_____ you have any questions, please do not hesitate to contact us.",
            options: ["Should", "Would", "Could", "Might"],
            correctAnswer: 0,
            section: .grammar,
            explanation: "'Should' en debut de phrase = inversion conditionnelle formelle, equivalent de 'If you should...'",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "The report was well-received; _____, some revisions were requested.",
            options: ["therefore", "moreover", "however", "consequently"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "'However' introduit un contraste/opposition avec ce qui precede.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "_____ completing the training, employees will receive a certificate.",
            options: ["Despite", "Upon", "Although", "While"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Upon + gerund' = immediatement apres avoir fait quelque chose. Formel.",
            difficulty: .advanced,
            partType: .part5
        ),
    ]

    // MARK: - BUSINESS VOCABULARY
    static let businessVocabQuestions: [Question] = [
        Question(
            text: "Please find _____ the documents you requested.",
            options: ["attached", "attaching", "attachment", "attach"],
            correctAnswer: 0,
            section: .businessEnglish,
            explanation: "'Please find attached' = veuillez trouver ci-joint. Expression standard des emails.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "We would like to _____ a meeting to discuss the contract terms.",
            options: ["scheme", "schedule", "sketch", "script"],
            correctAnswer: 1,
            section: .businessEnglish,
            explanation: "'Schedule a meeting' = planifier une reunion. Vocabulaire business courant.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The contract _____ that all disputes will be resolved through arbitration.",
            options: ["stimulates", "speculates", "stipulates", "simulates"],
            correctAnswer: 2,
            section: .businessEnglish,
            explanation: "'Stipulate' = stipuler, specifier dans un document legal/contrat.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "The company must _____ with all local regulations.",
            options: ["compete", "complete", "comply", "compliment"],
            correctAnswer: 2,
            section: .businessEnglish,
            explanation: "'Comply with' = se conformer a, respecter (des regles, reglements).",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "The quarterly _____ exceeded analysts' expectations.",
            options: ["earns", "earned", "earning", "earnings"],
            correctAnswer: 3,
            section: .businessEnglish,
            explanation: "'Quarterly earnings' = benefices trimestriels. Toujours pluriel en finance.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "We need to _____ a balance between quality and cost.",
            options: ["strike", "hit", "beat", "knock"],
            correctAnswer: 0,
            section: .businessEnglish,
            explanation: "'Strike a balance' = trouver un equilibre. Expression idiomatique business.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "The CEO will _____ the new strategy at the annual meeting.",
            options: ["uncover", "unfold", "unveil", "undo"],
            correctAnswer: 2,
            section: .businessEnglish,
            explanation: "'Unveil' = devoiler officiellement (un plan, produit, strategie).",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "The budget has been _____ for the upcoming fiscal year.",
            options: ["allocated", "located", "dislocated", "relocated"],
            correctAnswer: 0,
            section: .businessEnglish,
            explanation: "'Allocate' = allouer, attribuer (budget, ressources). Vocabulaire finance.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
    ]

    // MARK: - CONDITIONALS & SUBJUNCTIVE
    static let conditionalQuestions: [Question] = [
        Question(
            text: "The CEO insisted that the report _____ submitted by Friday.",
            options: ["is", "be", "was", "would be"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "Subjonctif apres 'insist that': base verbale 'be' sans 's', meme pour he/she/it.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "Had the company _____ the market trends earlier, it would have avoided losses.",
            options: ["analyze", "analyzed", "been analyzing", "to analyze"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "Inversion 3rd Conditional: 'Had + subject + past participle' = 'If + subject + had + past participle'.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "The regulations require that all employees _____ safety training annually.",
            options: ["completing", "complete", "completes", "completed"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "Subjonctif apres 'require that': base verbale sans 's'.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "Were the company _____ to expand, it would need additional funding.",
            options: ["decides", "decided", "to decide", "deciding"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "Inversion 2nd Conditional: 'Were + subject + to + infinitive' = forme conditionnelle formelle.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "It is essential that the client _____ notified immediately.",
            options: ["is", "be", "was", "being"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "Subjonctif apres 'it is essential that': base verbale 'be'.",
            difficulty: .advanced,
            partType: .part5
        ),
    ]

    // MARK: - READING COMPREHENSION (Part 7 style)
    static let readingQuestions: [Question] = [
        Question(
            text: "Email: 'I am writing to confirm our meeting scheduled for Thursday at 2 PM. Please let me know if this time is no longer convenient.' What is the purpose of this email?",
            options: ["To cancel a meeting", "To request a meeting", "To confirm an appointment", "To reschedule a meeting"],
            correctAnswer: 2,
            section: .reading,
            explanation: "'Writing to confirm' indique clairement l'intention de confirmer un rendez-vous.",
            difficulty: .intermediate,
            partType: .part7
        ),
        Question(
            text: "Notice: 'Due to scheduled maintenance, the parking garage will be closed from 10 PM Friday to 6 AM Monday.' How long will the garage be closed?",
            options: ["48 hours", "56 hours", "72 hours", "24 hours"],
            correctAnswer: 1,
            section: .reading,
            explanation: "Vendredi 22h a lundi 6h = 8h (ven) + 24h (sam) + 24h (dim) = 56 heures.",
            difficulty: .upperIntermediate,
            partType: .part7
        ),
        Question(
            text: "Memo: 'Effective immediately, all travel requests must be submitted at least two weeks in advance.' When does this policy take effect?",
            options: ["In two weeks", "Next month", "Immediately", "Next quarter"],
            correctAnswer: 2,
            section: .reading,
            explanation: "'Effective immediately' = avec effet immediat, des maintenant.",
            difficulty: .intermediate,
            partType: .part7
        ),
        Question(
            text: "Job posting: 'Candidates must have a minimum of 5 years of experience in marketing. An MBA is preferred but not required.' Is an MBA mandatory?",
            options: ["Yes, it is mandatory", "Only for senior candidates", "No, it is optional", "It depends on experience"],
            correctAnswer: 2,
            section: .reading,
            explanation: "'Preferred but not required' = souhaitable mais pas obligatoire.",
            difficulty: .intermediate,
            partType: .part7
        ),
        Question(
            text: "Report: 'While revenue increased by 15%, operating costs rose by 20%, resulting in a net decrease in profit margins.' What happened to profit margins?",
            options: ["They increased", "They remained stable", "They decreased", "They doubled"],
            correctAnswer: 2,
            section: .reading,
            explanation: "'Net decrease in profit margins' = diminution nette des marges.",
            difficulty: .upperIntermediate,
            partType: .part7
        ),
        Question(
            text: "Contract: 'Either party may terminate this agreement with 30 days written notice.' What is required to end the contract?",
            options: ["Immediate notice", "60 days notice", "Mutual agreement only", "30 days written notice"],
            correctAnswer: 3,
            section: .reading,
            explanation: "Le texte specifie explicitement '30 days written notice'.",
            difficulty: .upperIntermediate,
            partType: .part7
        ),
        Question(
            text: "Policy: 'Remote work arrangements must be approved by both the immediate supervisor and HR department.' Who must approve remote work?",
            options: ["Only the supervisor", "Only HR", "The CEO", "Both supervisor and HR"],
            correctAnswer: 3,
            section: .reading,
            explanation: "'Both the immediate supervisor and HR' = les deux approbations sont requises.",
            difficulty: .upperIntermediate,
            partType: .part7
        ),
        Question(
            text: "Announcement: 'The company will match employee charitable donations up to $500 per year.' What is the maximum company contribution per employee?",
            options: ["$250", "$1000", "$500", "Unlimited"],
            correctAnswer: 2,
            section: .reading,
            explanation: "'Match...up to $500' = l'entreprise contribue au maximum 500$ par employe.",
            difficulty: .intermediate,
            partType: .part7
        ),
        Question(
            text: "Press release: 'The acquisition, valued at $2.3 billion, is expected to close in Q2 pending regulatory approval.' What could delay the acquisition?",
            options: ["Financing issues", "The regulatory approval process", "Employee concerns", "Market conditions"],
            correctAnswer: 1,
            section: .reading,
            explanation: "'Pending regulatory approval' = en attente d'approbation reglementaire.",
            difficulty: .advanced,
            partType: .part7
        ),
        Question(
            text: "HR memo: 'Employees who have completed one year of service are eligible for the tuition reimbursement program.' What is the eligibility requirement?",
            options: ["Two years of service", "Manager approval", "Full-time status", "One year of service"],
            correctAnswer: 3,
            section: .reading,
            explanation: "'Completed one year of service' est la condition d'eligibilite mentionnee.",
            difficulty: .intermediate,
            partType: .part7
        ),
    ]

    // MARK: - RELATIVE CLAUSES & PRONOUNS
    static let relativeClauseQuestions: [Question] = [
        Question(
            text: "The merger, _____ was announced last month, will create the largest company in the industry.",
            options: ["that", "what", "which", "whose"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "'Which' pour une proposition relative non restrictive (avec virgules). 'That' ne peut pas suivre une virgule.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "The report, _____ findings were unexpected, has been widely discussed.",
            options: ["which", "that", "whose", "what"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "'Whose' indique la possession. 'Whose findings' = les resultats du rapport.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "The candidate _____ resume was most impressive got the job.",
            options: ["who", "whom", "whose", "which"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "'Whose' pour la possession (le CV de qui). 'Who' serait sujet, 'whom' objet.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "This is the project _____ I was telling you about.",
            options: ["who", "whom", "which", "whose"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "'Which' pour les choses. 'About which' ou 'which...about' sont corrects.",
            difficulty: .intermediate,
            partType: .part5
        ),
    ]

    // MARK: - INVERSIONS & ADVANCED STRUCTURES
    static let advancedStructureQuestions: [Question] = [
        Question(
            text: "Not only _____ the deadline, but they also exceeded the quality standards.",
            options: ["they met", "did they meet", "they did meet", "met they"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "Inversion apres 'Not only' en debut de phrase: auxiliaire + sujet + verbe.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "Never before _____ such rapid technological advancement.",
            options: ["the industry has seen", "has the industry seen", "the industry saw", "saw the industry"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "Inversion apres 'Never before': auxiliaire + sujet + participe passe.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "No sooner had the meeting started _____ the fire alarm went off.",
            options: ["when", "than", "that", "as"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'No sooner...than' est une structure fixe = a peine...que.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "_____ the circumstances, the board decided to postpone the launch.",
            options: ["Giving", "Given", "To give", "Gave"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Given' = etant donne. Utilise comme preposition pour introduire une circonstance.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "The manager emphasized the importance of _____ the reports submitted on time.",
            options: ["have", "having", "to have", "had"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "Apres 'of' (preposition), on utilise le gerondif (-ing).",
            difficulty: .advanced,
            partType: .part5
        ),
    ]

    // MARK: - OFFICIAL ETS-STYLE QUESTIONS (Based on Estudyme/ETS patterns 2024-2025)
    static let officialStyleQuestions: [Question] = [
        // Source: Estudyme TOEIC Part 5 Overview 2025
        Question(
            text: "The train _____ at 3 p.m. tomorrow.",
            options: ["will arrive", "arrives", "arrived", "arriving"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "Pour les horaires et programmes fixes (trains, avions, etc.), on utilise le Present Simple meme pour le futur.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "My boss _____ to Australia next month to open a new business.",
            options: ["travels", "will travel", "is travelling", "travelled"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "Present Continuous pour un plan futur deja decide et organise ('next month' + decision prise).",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "Sea Sapphire Cruises is _____ to announce the launch of their newest luxury ocean liner.",
            options: ["pleased", "pleasure", "pleasant", "pleasing"],
            correctAnswer: 0,
            section: .vocabulary,
            explanation: "'Pleased' (participe passe comme adjectif) decrit l'etat de la compagnie. 'Pleasant' decrirait quelque chose d'agreable.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "Remember that work-life balance issues can _____ anyone in any stage of the life cycle.",
            options: ["effect", "effective", "affect", "affection"],
            correctAnswer: 2,
            section: .vocabulary,
            explanation: "'Affect' (verbe) = influencer. 'Effect' est un nom. Apres 'can', on a besoin d'un verbe a l'infinitif.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The number of unemployed college graduates _____ increasing.",
            options: ["is", "are", "were", "have been"],
            correctAnswer: 0,
            section: .grammar,
            explanation: "'The number of' est toujours singulier. Attention: 'A number of' serait pluriel.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "Either he or his friends _____ you with your homework everyday.",
            options: ["help", "helps", "has helped", "is helping"],
            correctAnswer: 0,
            section: .grammar,
            explanation: "Avec 'either...or', le verbe s'accorde avec le sujet le plus proche ('friends' = pluriel).",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
    ]

    // MARK: - ADDITIONAL ADVANCED QUESTIONS (850+ level)
    static let advancedVocabularyQuestions: [Question] = [
        Question(
            text: "The company's decision to _____ its workforce resulted in significant cost savings.",
            options: ["downsize", "download", "downgrade", "downplay"],
            correctAnswer: 0,
            section: .businessEnglish,
            explanation: "'Downsize' = reduire les effectifs. Terme courant en restructuration d'entreprise.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "All complaints should be addressed to the customer service _____.",
            options: ["represent", "representative", "representation", "representing"],
            correctAnswer: 1,
            section: .vocabulary,
            explanation: "Apres 'service', on a besoin d'un nom. 'Representative' = representant du service client.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The merger is _____ to regulatory approval from the government.",
            options: ["subject", "subjected", "subjective", "subjectively"],
            correctAnswer: 0,
            section: .businessEnglish,
            explanation: "'Subject to' = soumis a, dependant de. Expression juridique/business courante.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "Participants are _____ encouraged to submit their feedback before Friday.",
            options: ["strong", "strongly", "strength", "strengthen"],
            correctAnswer: 1,
            section: .vocabulary,
            explanation: "Adverbe 'strongly' pour modifier le verbe 'encouraged'. 'Strong' est un adjectif.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The _____ of the new software has been delayed until next quarter.",
            options: ["implement", "implementation", "implemented", "implementing"],
            correctAnswer: 1,
            section: .vocabulary,
            explanation: "Apres 'The', on a besoin d'un nom. 'Implementation' = mise en oeuvre.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "Due to _____ circumstances, the flight has been cancelled.",
            options: ["unforeseen", "foreseeing", "foreseen", "foresee"],
            correctAnswer: 0,
            section: .vocabulary,
            explanation: "'Unforeseen circumstances' = circonstances imprevues. Expression tres courante.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The sales team has _____ its quarterly targets for the third consecutive quarter.",
            options: ["exceeded", "exceeding", "exceed", "excess"],
            correctAnswer: 0,
            section: .vocabulary,
            explanation: "Present Perfect: 'has exceeded'. 'Exceed targets' = depasser les objectifs.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "Ms. Johnson will _____ as interim CEO until a permanent replacement is found.",
            options: ["serve", "service", "servant", "serving"],
            correctAnswer: 0,
            section: .businessEnglish,
            explanation: "'Serve as' = exercer la fonction de. Apres 'will', base verbale.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The warranty does not cover damage caused by _____ use of the product.",
            options: ["proper", "improper", "properly", "improperly"],
            correctAnswer: 1,
            section: .vocabulary,
            explanation: "Adjectif 'improper' pour modifier le nom 'use'. 'Improper use' = mauvaise utilisation.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "Employees must obtain _____ approval before making any purchases over $500.",
            options: ["prior", "previous", "before", "formerly"],
            correctAnswer: 0,
            section: .vocabulary,
            explanation: "'Prior approval' = approbation prealable. 'Prior' est l'adjectif correct ici.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "The proposal was _____ rejected by the board of directors.",
            options: ["unanimous", "unanimity", "unanimously", "unite"],
            correctAnswer: 2,
            section: .vocabulary,
            explanation: "Adverbe 'unanimously' pour modifier le verbe 'rejected'. = a l'unanimite.",
            difficulty: .advanced,
            partType: .part5
        ),
        Question(
            text: "Please _____ your receipt for your records.",
            options: ["detain", "retain", "obtain", "contain"],
            correctAnswer: 1,
            section: .vocabulary,
            explanation: "'Retain' = conserver, garder. 'Obtain' = obtenir, 'Detain' = retenir (quelqu'un).",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "The company is seeking _____ candidates for the position.",
            options: ["qualify", "qualified", "qualification", "qualifying"],
            correctAnswer: 1,
            section: .vocabulary,
            explanation: "Adjectif 'qualified' pour modifier le nom 'candidates'. = candidats qualifies.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The meeting has been _____ until further notice.",
            options: ["supposed", "postponed", "proposed", "composed"],
            correctAnswer: 1,
            section: .vocabulary,
            explanation: "'Postponed until further notice' = reporte jusqu'a nouvel ordre. Expression standard.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The renovation project is _____ on schedule.",
            options: ["current", "presently", "currently", "present"],
            correctAnswer: 2,
            section: .vocabulary,
            explanation: "Adverbe 'currently' pour modifier 'on schedule'. = actuellement dans les temps.",
            difficulty: .intermediate,
            partType: .part5
        ),
    ]

    // MARK: - MORE GRAMMAR QUESTIONS (Collocations & Phrasal Verbs)
    static let collocationsQuestions: [Question] = [
        Question(
            text: "The manager needs to _____ up with a solution by tomorrow.",
            options: ["come", "go", "take", "put"],
            correctAnswer: 0,
            section: .grammar,
            explanation: "'Come up with' = trouver, proposer (une idee, solution). Phrasal verb tres courant.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "We need to _____ into account all the factors before making a decision.",
            options: ["put", "take", "get", "make"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Take into account' = prendre en compte. Collocation fixe.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The company has decided to _____ off the product launch.",
            options: ["put", "take", "get", "set"],
            correctAnswer: 0,
            section: .grammar,
            explanation: "'Put off' = reporter, remettre a plus tard. Phrasal verb courant en business.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "Please _____ sure that all documents are signed before submission.",
            options: ["do", "make", "get", "have"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Make sure' = s'assurer que. Collocation fixe avec 'make'.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The company will _____ advantage of the new tax regulations.",
            options: ["make", "do", "take", "get"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "'Take advantage of' = profiter de, tirer avantage de.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The new policy will _____ effect starting next month.",
            options: ["make", "take", "have", "do"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Take effect' = entrer en vigueur. Expression juridique/administrative.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "We look forward _____ hearing from you soon.",
            options: ["for", "to", "at", "on"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Look forward to + gerund' = avoir hate de. 'To' est une preposition ici, pas l'infinitif.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The results are _____ line with our expectations.",
            options: ["on", "in", "at", "by"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'In line with' = conforme a, en accord avec. Collocation fixe.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "I would like to _____ a reservation for two people.",
            options: ["do", "make", "take", "have"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Make a reservation' = faire une reservation. Collocation avec 'make'.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The project is still _____ progress.",
            options: ["on", "in", "at", "under"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'In progress' = en cours. Expression standard.",
            difficulty: .intermediate,
            partType: .part5
        ),
    ]

    // MARK: - GERUND vs INFINITIVE Questions
    static let gerundInfinitiveQuestions: [Question] = [
        Question(
            text: "The company decided _____ its headquarters to a new location.",
            options: ["relocating", "to relocate", "relocate", "relocated"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Decide' est suivi de l'infinitif avec 'to'. 'Decide to do something'.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "Would you mind _____ the window? It's quite hot in here.",
            options: ["open", "to open", "opening", "opened"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "'Mind' est suivi du gerondif (-ing). 'Would you mind doing something?'",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The manager suggested _____ the meeting until next week.",
            options: ["postpone", "to postpone", "postponing", "postponed"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "'Suggest' est suivi du gerondif ou 'that + subjonctif'. 'Suggest doing'.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "They agreed _____ the terms of the contract.",
            options: ["accepting", "to accept", "accept", "accepted"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Agree' est suivi de l'infinitif avec 'to'. 'Agree to do something'.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "I look forward to _____ you at the conference.",
            options: ["meet", "meeting", "met", "have met"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Look forward to' + gerondif. Attention: 'to' est une preposition, pas l'infinitif.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
        Question(
            text: "She avoided _____ about the budget cuts.",
            options: ["talk", "to talk", "talking", "talked"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "'Avoid' est toujours suivi du gerondif (-ing).",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "The CEO refused _____ on the rumours.",
            options: ["comment", "to comment", "commenting", "commented"],
            correctAnswer: 1,
            section: .grammar,
            explanation: "'Refuse' est suivi de l'infinitif avec 'to'.",
            difficulty: .intermediate,
            partType: .part5
        ),
        Question(
            text: "They considered _____ a new branch in Singapore.",
            options: ["open", "to open", "opening", "opened"],
            correctAnswer: 2,
            section: .grammar,
            explanation: "'Consider' est suivi du gerondif (-ing). 'Consider doing something'.",
            difficulty: .upperIntermediate,
            partType: .part5
        ),
    ]

    // MARK: - Combined Question Bank
    static var sampleQuestions: [Question] {
        return verbTenseQuestions +
               subjectVerbQuestions +
               wordFormQuestions +
               modalVerbQuestions +
               passiveVoiceQuestions +
               prepositionQuestions +
               conjunctionQuestions +
               businessVocabQuestions +
               conditionalQuestions +
               readingQuestions +
               relativeClauseQuestions +
               advancedStructureQuestions +
               officialStyleQuestions +
               advancedVocabularyQuestions +
               collocationsQuestions +
               gerundInfinitiveQuestions
    }

    static func questions(for section: QuestionSection?) -> [Question] {
        guard let section = section else {
            return sampleQuestions.shuffled()
        }
        return sampleQuestions.filter { $0.section == section }.shuffled()
    }

    static func questions(for difficulty: QuestionDifficulty) -> [Question] {
        return sampleQuestions.filter { $0.difficulty == difficulty }.shuffled()
    }
}
