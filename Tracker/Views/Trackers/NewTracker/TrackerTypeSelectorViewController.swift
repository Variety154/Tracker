//
//  TrackerTypeSelectorViewController.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 17.11.2024.
//

import UIKit

final class TrackerTypeSelectorViewController: LightStatusBarViewController {
    weak var delegate: TrackersViewProtocol?
    
    private var constraints = [NSLayoutConstraint]()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Создание трекера"
        label.font = Fonts.titleMediumFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Привычка", for: .normal)
        button.titleLabel?.font = Fonts.titleMediumFont
        button.setTitleColor(.ysWhite, for: .normal)
        button.backgroundColor = .ysBlack
        button.layer.cornerRadius = Constants.radius
        button.addTarget(self, action: #selector(habitButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var irregularEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Нерегулярные событие", for: .normal)
        button.titleLabel?.font = Fonts.titleMediumFont
        button.setTitleColor(.ysWhite, for: .normal)
        button.backgroundColor = .ysBlack
        button.layer.cornerRadius = Constants.radius
        button.addTarget(self, action: #selector(irregularEventButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout(){
        view.backgroundColor = .ysWhite
        
        view.addSubview(titleLabel)
        view.addSubview(titleLabel)
        view.addSubview(habitButton)
        view.addSubview(irregularEventButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Insets.leading),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Insets.trailing),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
            
            habitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -58),
            habitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            habitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            habitButton.heightAnchor.constraint(equalToConstant: 60),
            
            irregularEventButton.topAnchor.constraint(equalTo: habitButton.bottomAnchor, constant: 16),
            irregularEventButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            irregularEventButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            irregularEventButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    //MARK: - IB Outlet
    @IBAction
    private func habitButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            guard let self else {return}
            self.delegate?.showNewHabitViewController()
        }
    }
    
    @IBAction
    private func irregularEventButtonTapped(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            guard let self else {return}
            self.delegate?.showIrregularEventController()
        }
    }
}
