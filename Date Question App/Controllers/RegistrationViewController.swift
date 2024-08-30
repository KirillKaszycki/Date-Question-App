//
//  RegistrationViewController.swift
//  Date Question App
//
//  Created by Кирилл Кашицкий on 30.08.2024.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    var selectedGameType: GameType? // Тип игры, который был выбран на предыдущем экране
    
    private let playerOneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя 1"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let playerTwoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя 2"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Начать", for: .normal)
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [playerOneTextField, playerTwoTextField, startButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func startGame() {
        let questionVC = QuestionViewController()
        questionVC.playerOneName = playerOneTextField.text ?? "Игрок 1"
        questionVC.playerTwoName = playerTwoTextField.text ?? "Игрок 2"
        questionVC.selectedGameType = selectedGameType
        navigationController?.pushViewController(questionVC, animated: true)
    }
}
