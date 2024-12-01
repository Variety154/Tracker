//
//  TrackerCollectionViewCell.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 17.11.2024.
//

import UIKit

final class TrackerCollectionViewCell: UICollectionViewCell {
    private var tracker: Tracker?
    private var date: Date?
    private var dataProvider: TrackerRecordDataProviderProtocol?
    
    private var count: Int = 0
    private var isDone: Bool = false
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.titleMediumFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.labelFont
        label.textColor = .ysWhite
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var daysLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.labelFont
        label.textColor = .ysBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.radius
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    func configure(tracker: Tracker, date: Date , dataProvider: TrackerRecordDataProviderProtocol) {
        self.dataProvider = dataProvider
        self.date = date
        self.tracker = tracker
        
        emojiLabel.text = tracker.emoji.rawValue
        nameLabel.text = tracker.name
        cardView.backgroundColor = tracker.color.uiColor
        
        let trackerRecord = TrackerRecord(trackerId: tracker.id, date: date)
        updateStatisticsAndShow(trackerRecord: trackerRecord)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(cardView)
        cardView.addSubview(emojiLabel)
        cardView.addSubview(nameLabel)
        contentView.addSubview(daysLabel)
        contentView.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 90),
            
            emojiLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12),
            emojiLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            emojiLabel.widthAnchor.constraint(equalToConstant: 24),
            emojiLabel.heightAnchor.constraint(equalToConstant: 24),
            
            nameLabel.leadingAnchor.constraint(equalTo: emojiLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -12),
            nameLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12),
            
            plusButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 8),
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            plusButton.widthAnchor.constraint(equalToConstant: 34),
            plusButton.heightAnchor.constraint(equalToConstant: 34),
            
            daysLabel.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            daysLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 16),
            daysLabel.leadingAnchor.constraint(equalTo: emojiLabel.leadingAnchor),
        ])
    }
    
    private func setupPlusButton(isDone: Bool, color: UIColor) {
        if let date  {
            let isActive = date < Date()
            plusButton.alpha = isActive ? 0.7 : 1
            plusButton.isEnabled = isActive
        }
        
        let buttonImage = isDone ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "plus.circle.fill")
        
        plusButton.setImage(buttonImage, for: .normal)
        plusButton.tintColor = color
        plusButton.alpha = isDone ? 0.7 : 1
        
        plusButton.contentVerticalAlignment = .fill
        plusButton.contentHorizontalAlignment = .fill
        plusButton.imageView?.contentMode = .scaleAspectFit
        plusButton.imageEdgeInsets = .zero
    }
    
    private func formatDaysText(_ count: Int) -> String {
        let lastDigit = count % 10
        let lastTwoDigits = count % 100
        
        if lastTwoDigits >= 11 && lastTwoDigits <= 19 {
            return "\(count) дней"
        } else if lastDigit == 1 {
            return "\(count) день"
        } else if lastDigit >= 2 && lastDigit <= 4 {
            return "\(count) дня"
        } else {
            return "\(count) дней"
        }
    }
    
    private func updateStatisticsAndShow(trackerRecord: TrackerRecord) {
        guard
            let dataProvider,
            let tracker
        else { return }
        
        
        isDone = dataProvider.exist(trackerRecord: trackerRecord)
        count = dataProvider.count(trackerRecord: trackerRecord)
        
        setupPlusButton(isDone: isDone, color: tracker.color.uiColor)
        daysLabel.text = formatDaysText(count)
    }
    
    @IBAction
    private func plusButtonTapped() {
        guard let tracker,
              let dataProvider,
              let date,
              date < Date()
        else { return }
        
        let trackerRecord = TrackerRecord(trackerId: tracker.id, date: date)
        try? dataProvider.manageTrackerRecord(trackerRecord: trackerRecord)
        
        updateStatisticsAndShow(trackerRecord: trackerRecord)
    }
}

