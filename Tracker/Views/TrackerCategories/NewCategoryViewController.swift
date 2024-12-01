//
//  NewCategoryViewController.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 26.11.2024.
//

import UIKit

final class NewCategoryViewController: LightStatusBarViewController {
    weak var delegate: NewCategoryDelegateProtocol?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Новая категория"
        label.font = Fonts.titleMediumFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoryTextField: UITextField = {
        let textField = PaddedTextField()
//        let textField = UITextField()
        textField.placeholder = "Введите название категории"
        textField.font = Fonts.textFieldFont
        textField.backgroundColor = .ysBackground
        textField.layer.cornerRadius = Constants.radius
        textField.layer.masksToBounds = true
//        textField.textAlignment = .center
        textField.delegate = self
        textField.addTarget(self, action: #selector(categoryTextFieldChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = Fonts.titleMediumFont
        button.backgroundColor = .ysGray
        button.isEnabled = false
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Constants.radius
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(categoryTextField)
        view.addSubview(createButton)
        
        // Title Label Constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            categoryTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            categoryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoryTextField.heightAnchor.constraint(equalToConstant: 60),
       
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            createButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @IBAction
    private func categoryTextFieldChanged(_ textField: UITextField){
        let isEmpty = textField.text?.isEmpty ?? true
       
        if isEmpty {
            createButton.isEnabled = false
            createButton.backgroundColor = .ysGray
            return
        }
        
        createButton.isEnabled = true
        createButton.backgroundColor = .ysBlack
    }
    
    @IBAction
    func createButtonTapped(){
        guard let category = categoryTextField.text,
              let delegate
        else {return}
        
        delegate.didTapCreateButton(category: category)
        dismiss(animated: true, completion: nil)
    }
    
    
}

// MARK: - UITextViewDelegate
extension NewCategoryViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

