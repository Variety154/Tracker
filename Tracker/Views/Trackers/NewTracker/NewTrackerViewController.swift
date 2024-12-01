//
//  NewTrackerViewController.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 17.11.2024.
//

import UIKit

enum EventType: Int {
    case one_off = 1
    case habit = 2
    
    var description: String {
        switch self {
        case .habit:
            return "Новая привычка"
        case .one_off:
            return "Нерегулярное событие"
        }
    }
}

enum NewTrackerError: Error {
    case trackerCreationError
}

final class NewTrackerViewController: LightStatusBarViewController {
    var delegate: TrackersViewModelProtocol?
    var selectedDate: Date?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.bounces = false
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = eventType.description
        label.font = Fonts.titleMediumFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trackerNameTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = "Введите название трекера"
        textField.layer.cornerRadius = Constants.radius
        textField.delegate = self
        textField.backgroundColor = .ysBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(trackerNameTextFieldChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var tableView: UITableView  = {
        let table = UITableView()
        table.backgroundColor = .ysWhite
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.layer.cornerRadius = Constants.radius
        table.separatorInset = Insets.separatorInset
        table.isScrollEnabled = false
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var emojiSelectionView: EmojiSelectionView  = {
        let view = EmojiSelectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var colorSelectionView: ColorSelectionView  = {
        let view = ColorSelectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = Fonts.titleMediumFont
        button.layer.cornerRadius = Constants.radius
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.ysRed.cgColor
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Создать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Fonts.titleMediumFont
        button.backgroundColor = .ysGray
        button.layer.cornerRadius = Constants.radius
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let hStackView = UIStackView(arrangedSubviews: [cancelButton, createButton])
        hStackView.axis = .horizontal
        hStackView.distribution = .fillEqually
        hStackView.spacing = 8
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        return hStackView
    }()
    
    private let categoryCell: UITableViewCell = {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "Категория"
        cell.accessoryType = .disclosureIndicator
        cell.layoutMargins = Insets.cellInsets
        cell.backgroundColor = .ysBackground
        cell.textLabel?.font = Fonts.textFieldFont
        cell.detailTextLabel?.textColor = .ysGray
        cell.textLabel?.textColor = .ysBlack
        
        return cell
    }()
    
    private let scheduleCell: UITableViewCell = {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "Расписание"
        cell.accessoryType = .disclosureIndicator
        cell.layoutMargins = Insets.cellInsets
        cell.backgroundColor = .ysBackground
        cell.textLabel?.font = Fonts.textFieldFont
        cell.detailTextLabel?.textColor = .ysGray
        cell.textLabel?.textColor = .ysBlack
        
        return cell
    }()
    
    var eventType: EventType = .one_off
    private var selectedDays: WeekDays = WeekDays()
    private var selectedEmojiIndex: IndexPath?
    private var selectedColorIndex: IndexPath?
    private var selectedCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiSelectionView.delegate = self
        colorSelectionView.delegate = self
        setupLayout()
    }
    
    private func setupLayout(){
        view.backgroundColor = .ysWhite
        
        view.addSubview(scrollView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(trackerNameTextField)
        contentView.addSubview(tableView)
        contentView.addSubview(emojiSelectionView)
        contentView.addSubview(colorSelectionView)
        contentView.addSubview(buttonsStackView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            trackerNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            trackerNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            trackerNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            trackerNameTextField.heightAnchor.constraint(equalToConstant: 75),
            
            tableView.topAnchor.constraint(equalTo: trackerNameTextField.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Insets.leading),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Insets.trailing),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(eventType.rawValue * 75)),
            
            emojiSelectionView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            emojiSelectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            emojiSelectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            emojiSelectionView.heightAnchor.constraint(equalToConstant: CGFloat(220)),
            
            colorSelectionView.topAnchor.constraint(equalTo: emojiSelectionView.bottomAnchor, constant: 20),
            colorSelectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            colorSelectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            colorSelectionView.heightAnchor.constraint(equalToConstant: CGFloat(220)),
            
            buttonsStackView.topAnchor.constraint(equalTo: colorSelectionView.bottomAnchor, constant: 16),
            buttonsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
        updateCreateButtonState(isActive: validateTracker())
    }
    
    private func validateTracker() -> Bool {
        let isNameFilled = !(trackerNameTextField.text?.isEmpty ?? true)
        let isEmojiSelected = selectedEmojiIndex != nil
        let isColorSelected = selectedColorIndex != nil
        let isScheduled = eventType == .one_off ? true : !selectedDays.isEmpty
        let isCategorySelected = selectedCategory != nil
        
        let result = isNameFilled && isEmojiSelected && isColorSelected && isScheduled && isCategorySelected
        
        return result
    }
    
    private func updateCreateButtonState(isActive: Bool) {
        if isActive {
            createButton.backgroundColor = .ysBlack
            createButton.isEnabled = true
        } else {
            createButton.backgroundColor = .ysGray
            createButton.isEnabled = false
        }
    }
    
    //MARK: - IB Outlet
    @IBAction
    private func trackerNameTextFieldChanged(_ textField: UITextField){
        updateCreateButtonState(isActive: validateTracker())
    }
    
    @IBAction
    private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction
    private func createButtonTapped() {
        guard let name = trackerNameTextField.text,
              !name.isEmpty,
              let selectedDate,
              let delegate,
              let selectedEmojiIndex,
              let selectedColorIndex,
              let selectedCategory
        else {
            Log.error(error: NewTrackerError.trackerCreationError, message: "failed to create tracker")
            return
        }
        
        let color = TrackerColor.allCases[selectedColorIndex.item]
        
        let emoji = Emoji.allCases[selectedEmojiIndex.item]
        
        let schedule = (eventType == .habit) ? self.selectedDays : nil
        
        let tracker = Tracker(id: UUID(),
                              name: name,
                              color: color,
                              emoji: emoji,
                              date: selectedDate,
                              schedule: schedule)
        
        delegate.addTracker(tracker: tracker, category: selectedCategory)
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - UITableViewDelegate
extension NewTrackerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let trackerCategoriesViewController = CategoriesViewController()
            trackerCategoriesViewController.selectedCategory = self.selectedCategory
            trackerCategoriesViewController.delegate = self
            trackerCategoriesViewController.modalPresentationStyle = .pageSheet
            present(trackerCategoriesViewController, animated: true, completion: nil)
        } else {
            let scheduleViewController = ScheduleViewController()
            scheduleViewController.selectedDays = selectedDays
            scheduleViewController.delegate = self
            scheduleViewController.modalPresentationStyle = .pageSheet
            present(scheduleViewController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == eventType.rawValue - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
        } else {
            cell.separatorInset = Insets.separatorInset
        }
    }
}

//MARK: - UITableViewDataSource
extension NewTrackerViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventType.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return categoryCell
        } else {
            return scheduleCell
        }
    }
}

//MARK: - NewTrackerDelegateProtocol
extension NewTrackerViewController: NewTrackerDelegateProtocol {
    func didSelectDays(_ selectedDays: WeekDays) {
        self.selectedDays = selectedDays
        
        var detail = ""
        for day in selectedDays {
            if detail != "" {
                detail = detail + ", " + day.shortDescription
            } else {
                detail = day.shortDescription
            }
        }
        scheduleCell.detailTextLabel?.text = detail
        updateCreateButtonState(isActive: validateTracker())
    }
    
    func didSelectEmoji(_ indexPath: IndexPath) {
        self.selectedEmojiIndex = indexPath
        updateCreateButtonState(isActive: validateTracker())
    }
    
    func didSelectColor(_ indexPath: IndexPath) {
        self.selectedColorIndex = indexPath
        updateCreateButtonState(isActive: validateTracker())
    }
    
    func didSelectCategory(category: String) {
        self.selectedCategory = category
        categoryCell.detailTextLabel?.text = category
        updateCreateButtonState(isActive: validateTracker())
    }
}

// MARK: - UITextViewDelegate
extension NewTrackerViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        let length = (updatedText as NSString).length
        return length <= Constants.trackerNameMaxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
