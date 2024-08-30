//
//  GameTypeViewController.swift
//  Date Question App
//
//  Created by Кирилл Кашицкий on 30.08.2024.
//

import UIKit

class GameTypeViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let acquaintanceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Знакомство", for: .normal)
        button.addTarget(self, action: #selector(selectGameType), for: .touchUpInside)
        button.tag = 0
        return button
    }()
    
    private let romanticButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Романтические вопросы", for: .normal)
        button.addTarget(self, action: #selector(selectGameType), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    private let mixedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Смешанные вопросы", for: .normal)
        button.addTarget(self, action: #selector(selectGameType), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(acquaintanceButton)
        stackView.addArrangedSubview(romanticButton)
        stackView.addArrangedSubview(mixedButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func selectGameType(sender: UIButton) {
        // Здесь мы сохраняем выбранный режим и переходим на следующий экран
        let registrationVC = RegistrationViewController()
        switch sender.tag {
        case 0:
            registrationVC.selectedGameType = .acquaintance
        case 1:
            registrationVC.selectedGameType = .romantic
        case 2:
            registrationVC.selectedGameType = .mixed
        default:
            break
        }
        navigationController?.pushViewController(registrationVC, animated: true)
    }
}
