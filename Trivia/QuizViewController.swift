//
//  QuizViewController.swift
//  Trivia
//
//  Created by Bo on 3/12/25.
//
import UIKit

// Define a simple Question model.
struct Question {
    let text: String
    let answers: [String]
}

class QuizViewController: UIViewController {
    
    // At least 3 different questions.
    let questions: [Question] = [
        Question(text: "What is the capital of France?", answers: ["Paris", "London", "Berlin", "Madrid"]),
        Question(text: "Which planet is known as the Red Planet?", answers: ["Mars", "Earth", "Jupiter", "Saturn"]),
        Question(text: "What is the largest ocean on Earth?", answers: ["Pacific Ocean", "Atlantic Ocean", "Indian Ocean", "Arctic Ocean"])
    ]
    
    // Keep track of the current question index.
    var currentQuestionIndex = 0
    
    // UI Elements.
    let questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var answerButtons: [UIButton] = {
        var buttons = [UIButton]()
        for _ in 0..<4 {
            let button = UIButton(type: .system)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 8
            button.translatesAutoresizingMaskIntoConstraints = false
            buttons.append(button)
        }
        return buttons
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        showQuestion()
    }
    
    // Layout the question label and answer buttons.
    func setupLayout() {
        view.addSubview(questionLabel)
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // Create a vertical stack view to hold the answer buttons.
        let buttonsStackView = UIStackView(arrangedSubviews: answerButtons)
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 16
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 40),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        // Set a fixed height for each button and add tap actions.
        for button in answerButtons {
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.addTarget(self, action: #selector(answerTapped(_:)), for: .touchUpInside)
        }
    }
    
    // Show the current question and its answers.
    func showQuestion() {
        // If no more questions, show a completion message.
        guard currentQuestionIndex < questions.count else {
            questionLabel.text = "Quiz finished! Thanks for participating."
            answerButtons.forEach { $0.isHidden = true }
            return
        }
        
        let question = questions[currentQuestionIndex]
        questionLabel.text = question.text
        
        // Update button titles for the current question.
        for (index, button) in answerButtons.enumerated() {
            button.setTitle(question.answers[index], for: .normal)
            button.isHidden = false
        }
    }
    
    // Handle the tap event and move to the next question.
    @objc func answerTapped(_ sender: UIButton) {
        currentQuestionIndex += 1
        showQuestion()
    }
}
