//
//  ViewController.swift
//  Date Question App
//
//  Created by Кирилл Кашицкий on 30.08.2024.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var playerOneName: String?
    var playerTwoName: String?
    var selectedGameType: GameType?
    
    private var playerOneCount: Int = 0
    private var playerTwoCount: Int = 0
    private var currentPlayer: Int = 0
    
    private let currentTurnLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playerOneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playerTwoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fetchQuestionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Получить вопрос", for: .normal)
        button.addTarget(self, action: #selector(fetchQuestion), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        updateLabels()
        
        // Настройка кнопки "Назад"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "arrow.backward"),
            style: .plain,
            target: self,
            action: #selector(showBackAlert)
        )
    }
    
    private func setupLayout() {
        view.addSubview(currentTurnLabel)
        view.addSubview(fetchQuestionButton)
        
        let playersStackView = UIStackView(arrangedSubviews: [playerOneLabel, playerTwoLabel])
        playersStackView.axis = .horizontal
        playersStackView.distribution = .fillEqually
        playersStackView.spacing = 20
        playersStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(playersStackView)
        
        NSLayoutConstraint.activate([
            currentTurnLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            currentTurnLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playersStackView.topAnchor.constraint(equalTo: currentTurnLabel.bottomAnchor, constant: 20),
            playersStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            playersStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            fetchQuestionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            fetchQuestionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func updateLabels() {
        playerOneLabel.text = "\(playerOneName ?? "Игрок 1"): \(playerOneCount)"
        playerTwoLabel.text = "\(playerTwoName ?? "Игрок 2"): \(playerTwoCount)"
        
        let currentPlayerName = currentPlayer == 0 ? playerOneName : playerTwoName
        currentTurnLabel.text = "Сейчас ходит \(currentPlayerName ?? "Игрок")"
    }
    
    @objc private func fetchQuestion() {
        let question = getRandomQuestion()
        
        let alertController = UIAlertController(title: "Вопрос", message: question, preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.updateCounter()
            self.updateLabels()
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateCounter() {
        if currentPlayer == 0 {
            playerOneCount += 1
            currentPlayer = 1
        } else {
            playerTwoCount += 1
            currentPlayer = 0
        }
    }
    
    private func getRandomQuestion() -> String {
        guard let gameType = selectedGameType else { return "Ошибка: не выбран режим игры." }
        
        let questions: [String]
        switch gameType {
        case .acquaintance:
            questions = Questions.acquaintanceQuestions
        case .romantic:
            questions = Questions.romanticQuestions
        case .mixed:
            questions = Questions.mixedQuestions
        }
        
        return questions.randomElement() ?? "Нет доступных вопросов."
    }
    
    @objc private func showBackAlert() {
        let alertController = UIAlertController(title: "Выбор действия", message: nil, preferredStyle: .actionSheet)
        let changeModeAction = UIAlertAction(title: "Сменить режим", style: .default) { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        let changePlayersAction = UIAlertAction(title: "Поменять игроков", style: .default) { [weak self] _ in
            guard let self = self else { return }
            for vc in self.navigationController?.viewControllers ?? [] {
                if vc is RegistrationViewController {
                    self.navigationController?.popToViewController(vc, animated: true)
                    break
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertController.addAction(changeModeAction)
        alertController.addAction(changePlayersAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
