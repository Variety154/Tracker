//
//  TrackerViewController.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 17.11.2024.
//

import UIKit

enum EventType: Int {
    case oneOff
    case habit
    case updateOneOff
    case updateHabit
    
    var description: String {
        switch self {
        case .habit:
            return LocalizedStrings.Tracker.habitTitle
        case .oneOff:
            return LocalizedStrings.Tracker.oneOffTitle
        case .updateOneOff:
            return LocalizedStrings.Tracker.oneOffUpdateTitle
        case .updateHabit:
            return LocalizedStrings.Tracker.habitUpdateTitle
        }
    }
    
    var isOneOff: Bool {
        return self == .oneOff || self == .updateOneOff
    }
    
    var isHabit: Bool {
        return self == .habit || self == .updateHabit
    }
    
    var isNew: Bool {
        return self == .oneOff || self == .habit
    }
    
    var isUpdate: Bool {
        return self == .updateOneOff || self == .updateHabit
    }
    
    var numberOfCells: Int {
        return isOneOff ? 1 : 2
    }
}


enum TrackerError: Error {
    case trackerCreationError
}

final class TrackerViewController: BasicViewController {
    var delegate: TrackersViewModelProtocol?
    var selectedDate: Date?
    private var currentTracker: Tracker?
    
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
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.largeLabelFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trackerNameTextField: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = LocalizedStrings.Tracker.placeholderName
        textField.layer.cornerRadius = Constants.radius
        textField.delegate = self
        textField.backgroundColor = AppColors.Dynamic.background
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(trackerNameTextFieldChanged), for: .editingChanged)
        return textField
    }()
    
    private lazy var tableView: UITableView  = {
        let table = UITableView()
        table.backgroundColor = AppColors.Dynamic.white
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
        button.setTitle(LocalizedStrings.Tracker.cancelButton, for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = Fonts.titleMediumFont
        button.layer.cornerRadius = Constants.radius
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor =  AppColors.Fixed.red.cgColor
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        if eventType.isNew {
            button.setTitle(LocalizedStrings.Tracker.createButton, for: .normal)
        } else {
            button.setTitle(LocalizedStrings.Tracker.saveButton, for: .normal)
        }
        button.titleLabel?.font = Fonts.titleMediumFont
        button.setTitleColor(AppColors.Dynamic.white, for: .normal)
        button.backgroundColor = AppColors.Fixed.gray
        button.layer.cornerRadius = Constants.radius
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let hStackView = UIStackView(arrangedSubviews: [cancelButton, saveButton])
        hStackView.axis = .horizontal
        hStackView.distribution = .fillEqually
        hStackView.spacing = 8
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        return hStackView
    }()
    
    private let categoryCell: UITableViewCell = {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = LocalizedStrings.Tracker.categoryTitle
        cell.accessoryType = .disclosureIndicator
        cell.layoutMargins = Insets.cellInsets
        cell.backgroundColor = AppColors.Dynamic.background
        cell.textLabel?.font = Fonts.textFieldFont
        cell.detailTextLabel?.textColor = AppColors.Fixed.gray
        cell.textLabel?.textColor = AppColors.Dynamic.black
        
        return cell
    }()
    
    private let scheduleCell: UITableViewCell = {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = LocalizedStrings.Tracker.scheduleTitle
        cell.accessoryType = .disclosureIndicator
        cell.layoutMargins = Insets.cellInsets
        cell.backgroundColor = AppColors.Dynamic.background
        cell.textLabel?.font = Fonts.textFieldFont
        cell.detailTextLabel?.textColor = AppColors.Fixed.gray
        cell.textLabel?.textColor = AppColors.Dynamic.black
        
        return cell
    }()
    
    var eventType: EventType = .oneOff
    
    private var selectedDays: WeekDays = WeekDays()
    private var selectedEmojiIndex: IndexPath?
    private var selectedColorIndex: IndexPath?
    private var selectedCategory: String?
    
    // MARK: - View Life Cycles
    init() {
        super.init(nibName: nil, bundle: nil)
        self.screenName = AnalyticsEventData.NewTrackerScreen.name
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiSelectionView.delegate = self
        colorSelectionView.delegate = self
        setupLayout()
    }
    
    //MARK: - Public Methods
    func configure(with tracker: Tracker, category: String, count: Int) {
        currentTracker = tracker
        counterLabel.text = LocalizedStrings.TrackerCell.formatDaysText(days: count)
        trackerNameTextField.text = tracker.name
        selectedCategory = category
        categoryCell.detailTextLabel?.text = category
        selectedDays = tracker.schedule ?? WeekDays()
        scheduleCell.detailTextLabel?.text = tracker.schedule?.shortDescription ?? nil
        selectedEmojiIndex = Emoji.allCases.firstIndex(of: tracker.emoji).map { IndexPath(item: $0, section: 0) }
        selectedColorIndex = TrackerColor.allCases.firstIndex(of: tracker.color).map { IndexPath(item: $0, section: 0) }
        emojiSelectionView.selectEmoji(at: selectedEmojiIndex)
        colorSelectionView.selectColor(at: selectedColorIndex)
        updateSaveButtonState(isActive: validateTracker())
    }
    
    private func setupLayout(){
        view.backgroundColor = AppColors.Dynamic.white
        
        view.addSubview(scrollView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(trackerNameTextField)
        contentView.addSubview(tableView)
        contentView.addSubview(emojiSelectionView)
        contentView.addSubview(colorSelectionView)
        contentView.addSubview(buttonsStackView)
        scrollView.addSubview(contentView)
        
        var constraints: [NSLayoutConstraint] = []
        
        constraints.append(contentsOf: [
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
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
        ])
        
        
        if eventType.isNew {
            constraints.append(contentsOf: [
                trackerNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),

            ])
        } else {
            scrollView.addSubview(counterLabel)
            
            constraints.append(contentsOf: [
                counterLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
                counterLabel.widthAnchor.constraint(equalToConstant: 38),
                counterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                counterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                trackerNameTextField.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20),
            ])
        }
        
        
        constraints.append(contentsOf: [
            trackerNameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            trackerNameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            trackerNameTextField.heightAnchor.constraint(equalToConstant: 75),
            
            tableView.topAnchor.constraint(equalTo: trackerNameTextField.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Insets.leading),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Insets.trailing),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(eventType.numberOfCells * 75)),
            
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
        
        NSLayoutConstraint.activate(constraints)
        updateSaveButtonState(isActive: validateTracker())
    }
    
    private func validateTracker() -> Bool {
        let isNameFilled = !(trackerNameTextField.text?.isEmpty ?? true)
        let isEmojiSelected = selectedEmojiIndex != nil
        let isColorSelected = selectedColorIndex != nil
        let isScheduled = eventType.isOneOff  ? true : !selectedDays.isEmpty
        let isCategorySelected = selectedCategory != nil
        
        let result = isNameFilled && isEmojiSelected && isColorSelected && isScheduled && isCategorySelected
        
        return result
    }
    
    private func updateSaveButtonState(isActive: Bool) {
        if isActive {
            saveButton.backgroundColor = AppColors.Dynamic.black
            saveButton.isEnabled = true
        } else {
            saveButton.backgroundColor = AppColors.Fixed.gray
            saveButton.isEnabled = false
        }
    }
    
    //MARK: - IB Outlet
    @IBAction
    private func trackerNameTextFieldChanged(_ textField: UITextField){
        updateSaveButtonState(isActive: validateTracker())
    }
    
    @IBAction
    private func cancelButtonTapped() {
        Log.info(message: "reporting cancel event")
        AnalyticsService.shared.trackEvent(event: .click, params: AnalyticsEventData.NewTrackerScreen.clickCancel)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction
    private func saveButtonTapped() {
        guard let name = trackerNameTextField.text,
              !name.isEmpty,
              let selectedDate,
              let delegate,
              let selectedEmojiIndex,
              let selectedColorIndex,
              let selectedCategory
        else {
            Log.error(error: TrackerError.trackerCreationError, message: "failed to create tracker")
            return
        }
        
        Log.info(message: "reporting save event")
        AnalyticsService.shared.trackEvent(event: .click, params: AnalyticsEventData.NewTrackerScreen.clickSave)
        
        let color = TrackerColor.allCases[selectedColorIndex.item]
        
        let emoji = Emoji.allCases[selectedEmojiIndex.item]
        
        let schedule = eventType.isHabit  ? self.selectedDays : nil
        
        if eventType.isNew {
            let tracker = Tracker(id: UUID(),
                                  name: name,
                                  color: color,
                                  emoji: emoji,
                                  date: selectedDate,
                                  schedule: schedule,
                                  isPinned: false)
            delegate.addTracker(tracker: tracker, category: selectedCategory)
            
        } else {
            guard let id = currentTracker?.id,
                  let isPinned = currentTracker?.isPinned
            else {
                Log.warn(message: "failed to get tracker data for update")
                dismiss(animated: true, completion: nil)
                return
            }
            
            let tracker = Tracker(id: id,
                                  name: name,
                                  color: color,
                                  emoji: emoji,
                                  date: selectedDate,
                                  schedule: schedule,
                                  isPinned: isPinned)
            delegate.updateTracker(tracker: tracker, newCategory: selectedCategory)
        }
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - UITableViewDelegate
extension TrackerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let trackerCategoriesViewController = CategoriesViewController(delegate: self)
            trackerCategoriesViewController.selectedCategory = self.selectedCategory
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
        
        if indexPath.row == eventType.numberOfCells - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
        } else {
            cell.separatorInset = Insets.separatorInset
        }
    }
}

//MARK: - UITableViewDataSource
extension TrackerViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventType.numberOfCells
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
extension TrackerViewController: TrackerDelegateProtocol {
    func didSelectDays(_ selectedDays: WeekDays) {
        self.selectedDays = selectedDays
        
        var detail = ""
        
        if selectedDays != WeekDays.Daily {
            
            for day in selectedDays {
                if detail != "" {
                    detail = detail + ", " + day.shortDescription
                } else {
                    detail = day.shortDescription
                }
            }
        } else {
            detail = selectedDays.shortDescription
        }
        
        scheduleCell.detailTextLabel?.text = detail
        updateSaveButtonState(isActive: validateTracker())
    }
    
    func didSelectEmoji(_ indexPath: IndexPath) {
        self.selectedEmojiIndex = indexPath
        updateSaveButtonState(isActive: validateTracker())
    }
    
    func didSelectColor(_ indexPath: IndexPath) {
        self.selectedColorIndex = indexPath
        updateSaveButtonState(isActive: validateTracker())
    }
    
    func didSelectCategory(category: String) {
        self.selectedCategory = category
        categoryCell.detailTextLabel?.text = category
        updateSaveButtonState(isActive: validateTracker())
    }
}

// MARK: - UITextViewDelegate
extension TrackerViewController: UITextFieldDelegate{
    
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
